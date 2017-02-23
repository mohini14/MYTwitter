//
//  UserPost.m
//  MyTwitter
//
//  Created by Mohini on 18/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import "UserPost.h"

@interface UserPost ()

@end

@implementation UserPost

- (void)viewDidLoad {
    [super viewDidLoad];
	self.activityIndicator=[ActivityIndicator getInstanceForView:self];
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUp{
    self.editablePost = [SessionData getInstance].postToBeEdited;
    [SessionData getInstance].postToBeEdited = nil;
    if(self.editablePost == nil){
        self.deleteButton.hidden = YES;
    }else{
        self.textView.text = self.editablePost.post;
    }
}


- (IBAction)saveButtonPressed:(id)sender {

    NSString *post=self.textView.text;
    User *loggedInUser=[SessionData getInstance].loggedInUser;
    [self.textView resignFirstResponder];
	if(![self.textView.text isempty]){
        if(self.editablePost == nil) {
            [self.activityIndicator startActivityIndicatorWithMessage:@"Posting"];
            [UserServices submitPost:post withUsername:loggedInUser.username andCallBackMethod:^(Post *post, NSString *errorMessage) {
                [self.activityIndicator stopActivityIndicator];
                if (post != nil) {
                    [AlertManager showAlertPopupWithTitle:@"Success" andMessage:@"YOU POSTED SUCCESSFULLY" andActionTitle:@"ok" withBlock:^() {
                        [self performSegueWithIdentifier:@"unwindFromUSerPost" sender:self];
                    }                             forView:self
                    ];
                } else {
                    [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:errorMessage andActionTitle:@"ok" forView:self];
                }
            }];
        }else{
			[self.activityIndicator startActivityIndicatorWithMessage:@"Updating Your Post"];
			NSNumber *temp=self.editablePost.postId;
			NSString *post_Id = [temp stringValue];
			[UserServices updatePost:post withPostId:post_Id andWithCallBAckMethod:^(BOOL isSuccess, NSString *errorMessage) {
				if(isSuccess==true){
					[AlertManager showAlertPopupWithTitle:@"Success" andMessage:@"YOUR POST UPDATED SUCCESSFULLY" andActionTitle:@"ok" withBlock:^() {
						[self performSegueWithIdentifier:@"unwindFromUSerPost" sender:self];
					}                             forView:self
					 ];
				}
				else{
					[AlertManager showAlertPopupWithTitle:@"failed" andMessage:errorMessage andActionTitle:@"ok" forView:self];
				}
				}];
				}
	  }
		else{
			[AlertManager showAlertPopupWithTitle:@"oooops" andMessage:@"YOU CANNOT POST EMPTY TEXT" andActionTitle:@"ok" forView:self];
			}
	
}

- (IBAction)deleteButtonPressed:(UIButton *)sender {
	if(![self.textView.text isempty]){
		[self.activityIndicator startActivityIndicatorWithMessage:@"Deleting Your Post"];
		NSNumber *temp=self.editablePost.postId;
		NSString *post_Id = [temp stringValue];
		[UserServices DeletePost:post_Id andWithCallBAckMethod:^(BOOL isSuccess, NSString *errorMessage) {
			[self.activityIndicator stopActivityIndicator];
			if(isSuccess==true){
				[AlertManager showAlertPopupWithTitle:@"DELETD" andMessage:@"YOUR POST DELETED SUCCESSFULLY" andActionTitle:@"ok" withBlock:^() {
					[self performSegueWithIdentifier:@"unwindFromUSerPost" sender:self];
				}                             forView:self
				 ];
			}
			else{
				[AlertManager showAlertPopupWithTitle:@"failed" andMessage:errorMessage andActionTitle:@"ok" forView:self];
			}
		}];
		
		
		
		
		
	}else{
		[AlertManager showAlertPopupWithTitle:@"OOPS" andMessage:@"YOU ARE NOT DELETING A VALID POST" andActionTitle:@"OK" forView:self];
	}
}
@end
