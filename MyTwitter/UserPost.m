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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)saveButtonPressed:(id)sender {

    NSString *post=self.textView.text;
    User *loggedInUser=[SessionData getInstance].loggedInUser;

    [self.textView resignFirstResponder];
	if(![self.textView.text isempty]){
        [self.activityIndicator startActivityIndicatorWithMessage:@"Posting"];
        [UserServices submitPost:post withUsername:loggedInUser.username andCallBackMethod:^(Post *post,NSString *errorMessage) {
        [self.activityIndicator stopActivityIndicator];
        if(post!=nil){
            [AlertManager showAlertPopupWithTitle:@"Success" andMessage:@"YOU POSTED SUCCESSFULLY" andActionTitle:@"ok" withBlock:^() {
                    [self performSegueWithIdentifier:@"unwindFromUSerPost" sender:self];
                } forView:self
             ];
        }else{
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:errorMessage andActionTitle:@"ok" forView:self];
        }
        }];
	}
	else{
		[AlertManager showAlertPopupWithTitle:@"oooops" andMessage:@"YOU CANNOT SAVE WITHOUT POSTING" andActionTitle:@"ok" forView:self];
	}
	
}

@end
