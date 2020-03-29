//
//  UserInstance.h
//  MyLive
//
//  Created by sk on 2020/3/29.
//  Copyright © 2020 XSK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInstance : NSObject
+(UserInstance *)share;
@property(nonatomic,assign) BOOL hasLogin;
@end

NS_ASSUME_NONNULL_END
