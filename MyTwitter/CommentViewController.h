//
//  CommentViewController.h
//  MyTwitter
//
//  Created by Mohini on 19/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserServices.h"
#import "AlertManager.h"
#import "ActivityIndicator.h"
#import "CommentTableViewCell.h"
#import "Post.h"
#import "Comment.h"
#import "DateUtils.h"

@class SessionData;

@interface CommentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (weak, nonatomic) IBOutlet UITextField *addCommentTextField;
@property (strong,nonatomic) NSMutableDictionary *dict;
@property (strong,nonatomic) NSArray *commentTableData;
@property(strong,nonatomic) ActivityIndicator *activityIndicator;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) SessionData *sessionData;

- (IBAction)okCommentButtonPressed:(id)sender;



-(void)populateData;












@end
