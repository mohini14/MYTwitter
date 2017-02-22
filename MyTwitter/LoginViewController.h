//
//  LoginViewController.h
//  MyTwitter
//
//  Created by Mohini on 17/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserServices.h"
#import "AlertManager.h"
#import "NSString+Utils.h"
#import "UserProfile.h"
#import "User.h"
#import "SessionData.h"
@class ActivityIndicator;


@interface LoginViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITextField *userNameField;

@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UISwitch *rememberMeSwitch;

@property (weak, nonatomic) NSDictionary *userProfileData;


@property(nonatomic, strong) ActivityIndicator *activityIndicator;

- (IBAction)loginButtonPressed:(UIButton *)sender;
-(IBAction)unwindFromUserProfileVC:(UIStoryboardSegue *)unwindSegue;
-(IBAction)unwindFromHelpVC:(UIStoryboardSegue *)unwindSegue;

- (IBAction) switchAction:(UISwitch*)sender;

-(IBAction)unwindfromSignUpVC:(UIStoryboardSegue *)unwindSegue;
-(void) setKeepMeLoggedInSwitch:(UISwitch *)keepMeLoggedInSwitch;
@end
