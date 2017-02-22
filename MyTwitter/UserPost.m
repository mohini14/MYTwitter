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
        }
	}
	else{
		[AlertManager showAlertPopupWithTitle:@"oooops" andMessage:@"YOU CANNOT SAVE WITHOUT POSTING" andActionTitle:@"ok" forView:self];
	}
	
}

- (IBAction)deleteButtonPressed:(UIButton *)sender {
    [self.activityIndicator startActivityIndicatorWithMessage:@"Deleting Your Post"];
}
@end
