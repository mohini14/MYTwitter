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
//    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    NSString *user = [def stringForKey:@"textField1Text"];
//    
//    NSString *pass = [def stringForKey:@"textField2Text"];
//    
//    _userNameField.text = user;
//    _passwordField.text = pass;
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
    
    
    if(!([username isempty] || [password isempty])) {
       // [self keepMeLoggedInSwitch:_switchOutlet];//to see if keep me logged in option is on
        [UserServices login:username andPassword:password andCompletionHandler:^(BOOL isSuccess, NSDictionary *responseData, NSString *errorMessage) {
            if (isSuccess == TRUE) {
                //NSString *message = @"Login Successful";
               
                //[AlertManager showAlertPopupWithTitle:@"Success" andMessage:message andActionTitle:@"ok" forView:self];
                 [self preapareForSuccessfullLoginSEaguewithResponseData:responseData];
//              
                
            } else {
                if (errorMessage != nil) {
                    [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:errorMessage andActionTitle:@"ok" forView:self];
                } else {
                    [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:responseData[@"error"] andActionTitle:@"ok" forView:self];

                }
            }
        }];

    }else{
        [AlertManager showAlertPopupWithTitle:@"ooops" andMessage:@"You cannot leave any field empty" andActionTitle:@"ok" forView:self];
    }
}

//- (void)keepMeLoggedInSwitch:(UISwitch *)aSwitch {
//    UISwitch *sw = aSwitch;
//    if ([sw isOn]) {
//        NSString *saveName = self.userNameField.text;
//        NSString *savePassword = self.passwordField.text;
//
//        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//        [userDefault setObject:saveName forKey:@"name"];
//        [userDefault setObject:savePassword forKey:@"password"];
//        [userDefault synchronize];
//
//    }
//}
#pragma for segues//

-(void) preapareForSuccessfullLoginSEaguewithResponseData:(NSDictionary *)responseData{
    self.userProfileData = responseData;
    [self performSegueWithIdentifier:@"loggedInSeague" sender:self];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"loggedInSeague"]){
        UserProfile *up = segue.destinationViewController;
        NSDictionary *tempDict = @{
                @"username":self.userProfileData[@"result"][@"username"],
                @"name": [NSString stringWithFormat:@"%@ %@", self.userProfileData[@"result"][@"first_name"], self.userProfileData[@"result"][@"last_name"] ],
                @"email": self.userProfileData[@"result"][@"email"]
        };
        up.dict = tempDict;
    }
}

-(IBAction)unwindfromSignUpVC:(UIStoryboardSegue *)unwindSegue{
    //to come back from signup view controller
}


-(IBAction)unwindFromUserProfileVC:(UIStoryboardSegue *)unwindSegue{
    //to come back from UserProfile view Controller
}

-(IBAction)unwindFromHelpVC:(UIStoryboardSegue *)unwindSegue{
    //to come back from UserProfile view Controller
}
@end
