//
//  LoginViewController.m
//  MyTwitter
//
//  Created by Mohini on 17/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}













/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/















#pragma mark-unwind segues to come back to login page
- (IBAction)loginButtonPressed:(UIButton *)sender {

   NSString *username=self.userNameField.text;
    NSString *password=self.passwordField.text;
    [[self userNameField] resignFirstResponder];
    [[self passwordField] resignFirstResponder];

    [UserServices login:username andPassword:password andCompletionHandler:^(BOOL isSuccess,NSDictionary *responseData,NSString *errorMessage){
        if(isSuccess==TRUE){
            NSString *message=@"Login Successful";
            [AlertManager showAlertPopupWithTitle:@"Success" andMessage:message andActionTitle:@"ok" forView:self];
        } else{
            if(errorMessage != nil){
                [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:errorMessage andActionTitle:@"ok" forView:self];
            }else{
                [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:[responseData objectForKey:@"error"] andActionTitle:@"ok" forView:self];

            }}
    }];


}

-(IBAction)unwindfromSignUpVC:(UIStoryboardSegue *)unwindSegue{
    
}
@end
