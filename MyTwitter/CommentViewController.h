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

@interface CommentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) IBOutlet UILabel *postLabel;
@property (strong, nonatomic) IBOutlet UITextField *addCommentTextField;
@property (strong,nonatomic) NSMutableDictionary *dict;

@property(strong,nonatomic) ActivityIndicator *activityIndicator;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)okCommentButtonPressed:(id)sender;



-(void)populateData;












@end
