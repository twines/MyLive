//
//  UserInstance.m
//  MyLive
//
//  Created by sk on 2020/3/29.
//  Copyright © 2020 XSK. All rights reserved.
//

#import "UserInstance.h"

@interface UserInstance()

@end
@implementation UserInstance
+(UserInstance *)share{
    static UserInstance *instance ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[[self class] alloc] init];
        }
    });
    return instance;
}
@end
