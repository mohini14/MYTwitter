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


@interface LoginViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITextField *userNameField;

@property (strong, nonatomic) IBOutlet UITextField *passwordField;

//@property (strong, nonatomic) IBOutlet UISwitch *switchOutlet;

@property (weak, nonatomic) NSDictionary *userProfileData;









- (IBAction)loginButtonPressed:(UIButton *)sender;
-(IBAction)unwindFromUserProfileVC:(UIStoryboardSegue *)unwindSegue;
-(IBAction)unwindFromHelpVC:(UIStoryboardSegue *)unwindSegue;


- (void)preapareForSuccessfullLoginSEaguewithResponseData:(NSDictionary *)responseData;

-(IBAction)unwindfromSignUpVC:(UIStoryboardSegue *)unwindSegue;

//- (void)keepMeLoggedInSwitch:(UISwitch *)aSwitch;
@end
