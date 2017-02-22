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
	[self setFieldsFromNSUserDefaults];

	
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginButtonPressed:(UIButton *)sender {
  //  [ActivityBar activityBarOn :self];
   NSString *username=self.userNameField.text;
    NSString *password=self.passwordField.text;
    [[self userNameField] resignFirstResponder];
    [[self passwordField] resignFirstResponder];
	[self setKeepMeLoggedInSwitch:self.rememberMeSwitch];
    
    if(!([username isempty] || [password isempty])) {
        [self.activityIndicator startActivityIndicatorWithMessage:@"Loading.."];
        [UserServices login:username andPassword:password andCompletionHandler: ^(User *user,NSString *errorMsg){
			[self.activityIndicator stopActivityIndicator];
			if(errorMsg!=nil){
				[AlertManager showAlertPopupWithTitle:@"FAILED" andMessage:errorMsg andActionTitle:@"OK" forView:self];
			} else{
				[SessionData getInstance].loggedInUser = user;
//				[AlertManager showAlertPopupWithTitle:@"SUCCESS" andMessage:@"you have successfully logged in" andActionTitle:@"OK" forView:self];
				[self performSegueWithIdentifier:@"loggedInSeague" sender:self];			}
		}];

    }else{
        [AlertManager showAlertPopupWithTitle:@"OOPS" andMessage:@"You cannot leave any field empty" andActionTitle:@"ok" forView:self];
    }
}

#pragma for segues//




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
-(void)setFieldsFromNSUserDefaults{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
	if([defaults objectForKey:@"username"]!=nil){
		self.userNameField.text=[defaults objectForKey:@"username"];
		self.passwordField.text=[defaults objectForKey:@"password"];
		if(![self.rememberMeSwitch isOn])
			[self.rememberMeSwitch setOn:YES animated:YES];
	}
}


#pragma unwind segues
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
