//
//  CommentTableViewCell.h
//  MyTwitter
//
//  Created by Mohini Sindhu  on 20/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *postedatLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end
