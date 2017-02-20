//
//  LoginViewController.m
//  MyTwitter
//
//  Created by Mohini on 17/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import "LoginViewController.h"
#import "ActivityIndicator.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicator=[ActivityIndicator getInstanceForView:self];
	
	
	
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
	if([defaults objectForKey:@"username"]!=nil){
	self.userNameField.text=[defaults objectForKey:@"username"];
	self.passwordField.text=[defaults objectForKey:@"password"];
		if(![self.rememberMeSwitch isOn])
			[self.rememberMeSwitch setOn:YES animated:YES];
	}
	
	
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
  //  [ActivityBar activityBarOn :self];
   NSString *username=self.userNameField.text;
    NSString *password=self.passwordField.text;
    [[self userNameField] resignFirstResponder];
    [[self passwordField] resignFirstResponder];
	[self setKeepMeLoggedInSwitch:self.rememberMeSwitch];
	
    
    
    if(!([username isempty] || [password isempty])) {
        [self.activityIndicator startActivityIndicator];
        [UserServices login:username andPassword:password andCompletionHandler:^(BOOL isSuccess, NSDictionary *responseData, NSString *errorMessage) {
            [self.activityIndicator stopActivityIndicator];
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






-(void) setKeepMeLoggedInSwitch:(UISwitch *)keepMeLoggedInSwitch{
	UISwitch *sw=keepMeLoggedInSwitch;
	if([sw isOn]){
		NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
		[defaults setObject:self.userNameField.text forKey:@"username"];
		[defaults setObject:self.passwordField.text forKey:@"password"];
		[defaults synchronize];
		
	}
	else{
		NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
		if(([defaults objectForKey:@"username"] !=nil)|| ([defaults objectForKey:@"password"]!=nil)){
			[defaults setObject:nil forKey:@"username"];
			[defaults setObject:nil forKey:@"password"];
		}
			
	}
	
}
- (IBAction) switchAction:(UISwitch*)sender
{
	
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
