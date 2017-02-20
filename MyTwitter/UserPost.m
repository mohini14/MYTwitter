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
    NSString *username = self.userProfileDict[@"username"];
    [self.textView resignFirstResponder];
    [UserServices submitPost:post withUsername:username andCallBackMethod:^(BOOL isSuccess, NSDictionary *data, NSString *errorMessage) {
		[self.activityIndicator startActivityIndicator];
        
        if(isSuccess==TRUE){
			[self.activityIndicator stopActivityIndicator];
            
            //[AlertManager showAlertPopupWithTitle:@"Success" andMessage:@"Your post succesfully posted" andActionTitle:@"ok" forView:self];
            [AlertManager showAlertPopupWithTitle:@"Success" andMessage:@"YOU POSTED SUCCESSFULLY" andActionTitle:@"ok" withBlock:^()

                            {
                                [self performSegueWithIdentifier:@"unwindFromUSerPost" sender:self];
                            }

            forView:self
             ];
        
        }else if(isSuccess==FALSE && errorMessage!=nil){
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:@"server error" andActionTitle:@"ok" forView:self];
        } else{
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:@"something went wrong" andActionTitle:@"ok" forView:self];
        }
        
        

    
        
    }];
    
    
    
    
}

@end
