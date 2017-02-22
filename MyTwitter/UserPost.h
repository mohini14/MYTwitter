//
//  UserPost.h
//  MyTwitter
//
//  Created by Mohini on 18/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserServices.h"
#import "AlertManager.h"
#import "UserProfile.h"
#import "ActivityIndicator.h"

@interface UserPost : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property(strong,nonatomic) NSDictionary *userProfileDict;
@property (strong,nonatomic) ActivityIndicator *activityIndicator;

- (IBAction)saveButtonPressed:(id)sender;



@end
