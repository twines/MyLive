//
//  ApiFetch.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ApiFetch.h"
#import <YYKit/YYKit.h>
#import "AFNetworking.h"
#import "AppManager.h"
#import "AppModel.h"
#import "AppDelegate.h"
#import "UIViewController+ShowHud.h"
#import "LoginViewController.h"

//#define HOST @"http://47.94.139.201"
//#define PORT 9000
//#define HOST @"https://fish.diaoyuphb.com"
@interface ApiFetch()

@end
@implementation ApiFetch
+(ApiFetch *)share{
    static dispatch_once_t onceToken;
    static ApiFetch *apiFetch  ;
    dispatch_once(&onceToken, ^{
        apiFetch = [[ApiFetch alloc] init];
    });
    return apiFetch;
}
-(void)postFetch:(NSString *)api
            body:(NSDictionary *)params
       onSuccess:(nonnull void (^)(AppModel  * _Nonnull modelValue, id responseObject)) onSuccess
               onFailure:(void(^)(NSString * message, NSString * shortLink)) onFailure {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    if ([[AppManager manager] userHasLogin]) {
        
        [manager.requestSerializer setValue:[AppManager manager].token
                         forHTTPHeaderField:@"token"];
    }
    NSString * url = [NSString stringWithFormat:@"%@%@",API_HOST,api];
    NSLog(@"parameters = %@",params);

    [manager POST:url
       parameters:params
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        AppModel *modelValue =   [AppModel modelWithJSON:responseObject];
        NSLog(@"base = %@",responseObject);
        if (onSuccess&& modelValue.isSuccess) {
            onSuccess(modelValue,responseObject);
        }else{
            [self showLogin:modelValue];
            [self toast:modelValue.msg];
            
            onFailure(modelValue.msg,api);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           NSString * message = @"网络连接出现问题";
                if (onFailure) {
                    onFailure(message,api);
                }
                  NSLog(@"开发网络问题%@:%@",task,error);
                 [self toast:message];
    }];
}
-(void)postFetch:(NSString *)url
            body:(NSDictionary *)params
          holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
       dataModel:(Class)dataModel
       onSuccess:(void (^)(NSObject * _Nonnull, id _Nonnull))onSuccess{
    @weakify(hoderVc)
      if ([weak_hoderVc respondsToSelector:@selector(autoHudForLink:)]) {
          if ([weak_hoderVc autoHudForLink:url]) {
              [weak_hoderVc showDefaultLoading];
          }
      }else{
          [weak_hoderVc showDefaultLoading];
      }
    
    [self postFetch:url
               body:params
          onSuccess:^(AppModel * _Nonnull modelValue, id  _Nonnull responseObject) {
          [weak_hoderVc hideHud];
                NSObject * dataValue =nil;
             dataValue =   [modelValue dataFor:dataModel];
        #if Debug
                NSLog(@"%@ \t%@====%@",url,[params jsonStringEncoded],dataValue);
        #endif
                onSuccess(dataValue , responseObject);
        
    }  onFailure:^(NSString * _Nonnull message, NSString * _Nonnull shortLink) {
               if ([weak_hoderVc respondsToSelector:@selector(autoHudForLink:)]) {
                     if ([weak_hoderVc autoHudForLink:shortLink]) {
                         [weak_hoderVc hideHud];
                     }
                 }else{
                     [weak_hoderVc hideHud];
                 }
                 
               if ([hoderVc respondsToSelector:@selector(onOptionalFailureHandler:uri:)]) {
                   [hoderVc onOptionalFailureHandler:message
                                                 uri:shortLink];
               }
       //        [weak_hoderVc.view makeToast:message];
           }];
}

-(void)getFetch:(NSString *)url
          query:(NSDictionary *)params
         holder:(UIViewController<ApiFetchOptionalHandler> *)hoderVc
      dataModel:(Class)dataModel
      onSuccess:(void (^)(NSObject * _Nonnull, id _Nonnull))onSuccess{
        @weakify(hoderVc)
    if ([weak_hoderVc respondsToSelector:@selector(autoHudForLink:)]) {
        if ([weak_hoderVc autoHudForLink:url]) {
            [weak_hoderVc showDefaultLoading];
        }
    }else{
        [weak_hoderVc showDefaultLoading];
    }
    
        [self getFetch:url query:params
                 onSuccess:^(AppModel * _Nonnull modelValue, id  _Nonnull responseObject) {
            [weak_hoderVc hideHud];
            NSObject * dataValue =nil;
         dataValue =   [modelValue dataFor:dataModel];
    
            onSuccess(dataValue , responseObject);
        } onFailure:^(NSString * _Nonnull message, NSString * _Nonnull shortLink) {
            if ([weak_hoderVc respondsToSelector:@selector(autoHudForLink:)]) {
                  if ([weak_hoderVc autoHudForLink:shortLink]) {
                      [weak_hoderVc hideHud];
                  }
              }else{
                  [weak_hoderVc hideHud];
              }
              
            if ([hoderVc respondsToSelector:@selector(onOptionalFailureHandler:uri:)]) {
                [hoderVc onOptionalFailureHandler:message
                                              uri:shortLink];
            }
    //        [weak_hoderVc.view makeToast:message];
        }];
}
-(void)getFetch:(NSString *)api
          query:(NSDictionary *)queries
      onSuccess:(void (^)(AppModel  * _Nonnull modelValue, id _Nonnull))onSuccess
      onFailure:(void(^)(NSString * message, NSString * shortLink)) onFailure {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = nil;
    if ([[AppManager manager] userHasLogin]) {
        
        [manager.requestSerializer setValue:[AppManager manager].token
                         forHTTPHeaderField:@"token"];
    }
    NSString * url = [NSString stringWithFormat:@"%@/fishing%@",API_HOST,api];
    [manager GET:url
      parameters:queries
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        AppModel *modelValue =   [AppModel modelWithJSON:responseObject];
        NSLog(@"base = %@",responseObject);
        if (onSuccess&& modelValue.isSuccess) {
            onSuccess(modelValue,responseObject);
        }else{
            [self showLogin:modelValue];
            [self toast:modelValue.msg];
            onFailure(modelValue.msg,api);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString * message = @"网络连接出现问题";
        if (onFailure) {
            onFailure(message,api);
        }
 
        [self toast:message];
    }];
}
-(void)showLogin:(AppModel *) modelValue{
     if (modelValue.code == 4001) {
    AppDelegate * appDelegate = ( AppDelegate * ) [UIApplication sharedApplication].delegate;
    UIViewController *rootVc =  appDelegate.window.rootViewController;
    UIViewController * topVc = nil;
    if ([rootVc isKindOfClass:UINavigationController.class]) {
        topVc = ((UINavigationController *)rootVc).topViewController;
    }else{
        topVc = rootVc;
    }
        
         
    
     }
}

-(void)toast:(NSString *) message{
    if ([message isEqualToString:@"Unauthorized"]) {
        return;
    }
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDelegate.window.rootViewController makeToask:message];
}
@end
