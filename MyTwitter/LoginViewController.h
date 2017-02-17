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

@interface LoginViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITextField *userNameField;

@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@property (strong, nonatomic) IBOutlet UISwitch *keepMeLoggedInSwitch;








- (IBAction)loginButtonPressed:(UIButton *)sender;










-(IBAction)unwindfromSignUpVC:(UIStoryboardSegue *)unwindSegue;
@end
