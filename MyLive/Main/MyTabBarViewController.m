//
//  MyTabBarViewController.m
//  MyLive
//
//  Created by sk on 2020/3/29.
//  Copyright © 2020 XSK. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "LoginViewController.h"
#import "MyCenterViewController.h"
#import "UserInstance.h"
@interface MyTabBarViewController ()<UITabBarControllerDelegate,UITabBarDelegate>

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController API_AVAILABLE(ios(3.0)){
    if ([viewController isKindOfClass:[MyCenterViewController class]]) {
        if ([UserInstance share].hasLogin) {
            return YES;
        }
        LoginViewController *loginVc =  [self.storyboard instantiateViewControllerWithIdentifier:Login_VC_ID];
              [self presentViewController:loginVc
                                 animated:YES
                               completion:^{
                  
              }];
        return NO;
    }
    
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
