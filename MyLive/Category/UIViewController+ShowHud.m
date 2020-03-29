//
//  UIViewController+ShowHud.m
//  FishingLeaderBoard
//
//  Created by liyulong on 2019/10/31.
//  Copyright © 2019 yue. All rights reserved.
//

#import "UIViewController+ShowHud.h"
#import "UIView+Toast.h"


@implementation UIViewController (ShowHud)
-(void)loading{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)loadingWithMessage:(NSString *)msg mode:(MBProgressHUDMode)mode{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = mode;
    hud.label.text = msg;
}
-(void)hideHud{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)showDefaultInfo:(NSString *)str
{
    [self showWithInfo:str delayToHideAfter:3];
}
-(void)showDefaultLoading{
    [self showJiZaiInfo:@"网络请求中……"];
}
-(void)makeToask:(NSString *)message{
    if (message.length==0) {
        return;
    }
    [self.view makeToast:message];
}
@end
