//
//  LoginViewController.m
//  MyLive
//
//  Created by sk on 2020/3/29.
//  Copyright © 2020 XSK. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameView;
@property (weak, nonatomic) IBOutlet UITextField *passwordView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (IBAction)goToLogin:(id)sender {
    NSString *username = self.userNameView.text;
          NSString * password = self.passwordView.text;
       if ((username.length && password.length ) == nil) {
           [self  makeToask:@"用户名h或密码不能为空"];
           return;
       }
          [[ApiFetch share] postFetch:@"/login" body:@{@"username":username, @"password": password}
                            onSuccess:^(AppModel * _Nonnull model, id  _Nonnull responseObject) {
              
              [self makeToask:model.msg];
              [self dismissViewControllerAnimated:YES
                                       completion:^{
                  
              }];
              
          } onFailure:^(NSString * _Nonnull message, NSString * _Nonnull shortLink) {
              [self makeToask:message];
          }];}

- (IBAction)pushToRegister:(id)sender {
    RegisterViewController * registerVc = [self.storyboard instantiateViewControllerWithIdentifier:Register_VC_ID];
    
    [self presentViewController:registerVc
                       animated:YES completion:^{
        
    }];
}

@end
