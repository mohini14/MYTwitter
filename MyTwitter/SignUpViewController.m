//
//  SignUpViewController.m
//  MyTwitter
//
//  Created by Mohini on 17/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import "SignUpViewController.h"
#import "NSString+Utils.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.activityIndicator=[ActivityIndicator getInstanceForView:self];

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

- (IBAction)signupButtonPressed:(UIButton *)sender {
    NSString *fname=self.fnameField.text;
    NSString *lname=self.lnameField.text;
    NSString *username = self.usernameField.text;
    NSString *email=self.emailidField.text;
    if([AlertManager validateEmail:email]){
    
    NSString *password=self.passwordField.text;
    NSString *confirmpassword=self.confirmPasswordField.text;
   //creating dict
    NSMutableDictionary *dict=[NSMutableDictionary new];
    dict[@"first_name"]=fname;
    dict[@"last_name"]=lname;
    dict[@"username"]=username;
    dict[@"email"]=email;
    dict[@"password"]=password;

    if(!(([fname isempty])||([lname isempty])||([email isempty])||([password isempty]) ||([confirmpassword isempty]) || [username isempty])){
       if([password isEqualToString:confirmpassword]){
		   [self.activityIndicator startActivityIndicator];
        [UserServices register:dict andCallBackMethod:^(BOOL isSuccess,NSDictionary *responseData,NSString *errorMessage){
			[self.activityIndicator stopActivityIndicator];
            if(isSuccess==TRUE){
                NSString *message=@"Registered Successfully";
                [AlertManager showAlertPopupWithTitle:@"Success" andMessage:message andActionTitle:@"ok" forView:self];
            } else{
                if(errorMessage != nil){
                    [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:errorMessage andActionTitle:@"ok" forView:self];
                }else{
                    [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:[responseData objectForKey:@"error"] andActionTitle:@"ok" forView:self];

                }}



        }];




       } else{
           [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:@"password and confirm password fields did not match" andActionTitle:@"0k" forView:self];
       }

    }else{
        [AlertManager showAlertPopupWithTitle:@"Oooops" andMessage:@"You cannot leave any field empty" andActionTitle:@"ok" forView:self];
    }
    
    }else{
        [AlertManager showAlertPopupWithTitle:@"Ooops" andMessage:@"Enter a valid email" andActionTitle:@"ok" forView:self];
    }
    
    
    
    
}
@end
