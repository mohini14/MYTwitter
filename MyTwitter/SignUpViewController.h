//
//  SignUpViewController.h
//  MyTwitter
//
//  Created by Mohini on 17/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertManager.h"
#import "UserServices.h"
#import "ActivityIndicator.h"


@interface SignUpViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *fnameField;


@property (strong, nonatomic) IBOutlet UITextField *lnameField;

@property (strong, nonatomic) IBOutlet UITextField *emailidField;

@property (strong, nonatomic) IBOutlet UITextField *usernameField;


@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordField;

- (IBAction)signupButtonPressed:(UIButton *)sender;
@property (strong,nonatomic) ActivityIndicator *activityIndicator;






@end
