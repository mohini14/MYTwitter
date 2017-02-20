//
//  CommentViewController.m
//  MyTwitter
//
//  Created by Mohini on 19/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.postLabel.text=_dict[@"post"];
    self.nameLabel.text=_dict[@"username"];//fetching for displaying purpose
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self populateData];
   self.activityIndicator= [ActivityIndicator getInstanceForView:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell"];
    if(cell==nil)
	   {
		  NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentTableViewCell" owner:self options:nil];
		  cell = [nib objectAtIndex:0];

	   }
    
	   cell.commentLabel.text=_tableData[indexPath.row][@"comments"];
	   cell.usernameLabel.text=[_dict valueForKey:@"usernameToComments"];
	   cell.postedatLabel.text=_tableData[indexPath.row][@"created_at"];
	   
    
    
    //cell.textLabel.text= self.tableData[(NSUInteger) indexPath.row][@"comment"];
    return cell;
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  120;
}



- (IBAction)okCommentButtonPressed:(id)sender {
    
    
    
    NSString *addCommentText=self.addCommentTextField.text;
     NSString *postID=[NSString stringWithFormat:@"%@",_dict[@"post_id"]];
    [self.activityIndicator startActivityIndicator];
    [UserServices addComment:addCommentText withPostID:postID withUserName:_dict[@"username"] andCallBackMethod:^(BOOL isSuccess, NSDictionary *data, NSString *errorMessage) {
	   
	   [self.activityIndicator stopActivityIndicator];
        if (isSuccess == TRUE) {
            
            [self populateData];
            [AlertManager showAlertPopupWithTitle:@"Success" andMessage:@"YOU HAVE SUCCESSFULLY ADDED COMMENT" andActionTitle:@"ok" forView:self];
            [[self addCommentTextField]resignFirstResponder];
            self.addCommentTextField.text=nil;
        
        
        } else if (isSuccess == FALSE && errorMessage != nil) {
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:@"server error" andActionTitle:@"ok" forView:self];
        } else {
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:@"something went wrong" andActionTitle:@"ok" forView:self];
        }

    }];
    
    
}

-(void)populateData{

        NSString *postID=[NSString stringWithFormat:@"%@",_dict[@"post_id"]];

    [UserServices getPostForPostID :postID andCallBackMethod:^(BOOL isSuccess, NSDictionary *data, NSString *errorMessage) {
        if(isSuccess==TRUE){
            self.tableData = [@[] mutableCopy];
            for (NSDictionary *obj in data[@"result"][@"comments"]){//for each loop to retrieve data from json;

                NSDictionary *tempDict=@{

                        @"comments":obj[@"comment"],
                        @"username":obj[@"user"][@"username"],
                        @"likes":obj[@"likes"],
				    @"created_at":obj[@"created_at"]
                };
                [self.tableData addObject:tempDict];
            }
		  NSLog(@"username value%@",_tableData[0][@"username"]);
            [self.tableView reloadData];
            self.postLabel.text=data[@"result"][@"post"];//updating postlabel field again after populating data
        }else if(isSuccess==FALSE && errorMessage!=nil){
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:@"server error" andActionTitle:@"ok" forView:self];
        } else{
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:@"something went wrong" andActionTitle:@"ok" forView:self];
        }

    }];
}



@end
