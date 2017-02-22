//
//  CommentViewController.m
//  MyTwitter
//
//  Created by Mohini on 19/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import "CommentViewController.h"
#import "Post.h"

@interface CommentViewController ()

@end

@implementation CommentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.postLabel.text= _displayPost.post;
    self.nameLabel.text= _displayPost.user.username;//fetching for displaying purpose
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
    return self.commentTableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell"];
    if(cell==nil)
	   {
		  NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentTableViewCell" owner:self options:nil];
		  cell = [nib objectAtIndex:0];

	   }
    
	   Comment *comment=_commentTableData[indexPath.row];
	   if(_commentTableData.count!=0){//if i tried to access empty array then its giving errori.e if a post does not have comment.
	   cell.commentLabel.text=comment.comment;
	   cell.usernameLabel.text=comment.user.username;
	   cell.postedatLabel.text=[DateUtils Datetoiso8601 : comment.createdAt];
	   }
    
    
        return cell;
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  120;
}



- (IBAction)okCommentButtonPressed:(id)sender {
    
    
    
    NSString *addCommentText=self.addCommentTextField.text;
    [_addCommentTextField resignFirstResponder];
    NSString *postID=[NSString stringWithFormat:@"%@",_displayPost.postId];
    [self.activityIndicator showLoadingViewMessage:@"wait...."];
    [self.activityIndicator startActivityIndicator];
    if(addCommentText.length!=0){
    [UserServices addComment:addCommentText withPostID:postID withUserName:_displayPost.user.username andCallBackMethod:^(BOOL isSuccess, NSDictionary *data, NSString *errorMessage) {
	   [self.activityIndicator removeLoadedMessage];
	   [self.activityIndicator stopActivityIndicator];
        if (isSuccess == TRUE) {
            
		  
		  [AlertManager showAlertPopupWithTitle:@"SUCCESS" andMessage:@"YOU HAVE SUCCESSFULLY ADDED COMMENT" andActionTitle:@"ok" forView:self];
            self.addCommentTextField.text=nil;
		  [self populateData];
        
        
        } else if (isSuccess == FALSE && errorMessage != nil) {
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:errorMessage andActionTitle:@"ok" forView:self];
	   }

    }];
    
    }else{
	   [AlertManager showAlertPopupWithTitle:@"OOOOPS" andMessage:@"YOU CANNOT POST AN EMPTY COMMENT" andActionTitle:@"ok" forView:self];
    }
}

-(void)populateData{

        NSString *postID=[NSString stringWithFormat:@"%@",_displayPost.postId];
	   [self.activityIndicator startActivityIndicator];
	   [self.activityIndicator showLoadingViewMessage:@"loading..."];
	   [UserServices getPostForPostID :postID andCallBackMethod:^(BOOL isSuccess, NSArray *data, NSString *errorMessage) {
		  [self.activityIndicator removeLoadedMessage];
		  [self.activityIndicator stopActivityIndicator];
        if(isSuccess==TRUE){
		  
		  self.commentTableData=data;
            [self.tableView reloadData];
		  self.postLabel.text=self.displayPost.post;//updating postlabel field again after populating data
        }else if(isSuccess==FALSE && errorMessage!=nil){
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:errorMessage andActionTitle:@"ok" forView:self];
	   }

    }];
}



@end
