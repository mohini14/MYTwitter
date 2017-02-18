//
//  UserProfile.h
//  MyTwitter
//
//  Created by Mohini on 18/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface UserProfile : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *emailIdLabel;
@property (strong, nonatomic) NSDictionary *dict;
-(IBAction)unwindFromUserPost:(UIStoryboardSegue *)segue;




















@end
