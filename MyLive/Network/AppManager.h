//
//  AppManager.h
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfo;
NS_ASSUME_NONNULL_BEGIN

@interface AppManager : NSObject
+(AppManager *)manager;
-(BOOL) userHasLogin;
@property(readonly,getter=userToken) NSString * token;
@property(copy,nonatomic) UserInfo * userInfo;

@end

NS_ASSUME_NONNULL_END
