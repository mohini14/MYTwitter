//
//  PostTableCell.h
//  MyTwitter
//
//  Created by Mohini on 19/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *postedAtLabel;
@property (strong, nonatomic) IBOutlet UILabel *likesLabel;
@property (strong, nonatomic) IBOutlet UILabel *postLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageHolder;
@property (strong, nonatomic) IBOutlet UIButton *editButton;


@end
