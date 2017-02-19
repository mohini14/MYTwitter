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

@interface CommentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) IBOutlet UILabel *postLabel;
@property (strong, nonatomic) NSDictionary *dict;



@property (strong, nonatomic) IBOutlet UITableView *tableView;



-(void)populateData;












@end
