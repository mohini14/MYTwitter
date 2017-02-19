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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)saveButtonPressed:(id)sender {
    NSString *text=self.textView.text;
    [self.textView resignFirstResponder];
    NSMutableDictionary *dictionary=[NSMutableDictionary new];
    dictionary[@"post"]=text;
    dictionary[@"username"]=self.userProfileDict[@"username"];
    [UserServices submitPost:dictionary andCallBackMethod:^(BOOL isSuccess, NSDictionary *data, NSString *errorMessage) {
        
        if(isSuccess==TRUE){
            
            [AlertManager showAlertPopupWithTitle:@"Success" andMessage:@"Your post succesfully posted" andActionTitle:@"ok" forView:self];
            
            
        }else if(isSuccess==FALSE && errorMessage!=nil){
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:@"server error" andActionTitle:@"ok" forView:self];
        } else{
            [AlertManager showAlertPopupWithTitle:@"Failed" andMessage:@"something went wrong" andActionTitle:@"ok" forView:self];
        }
        
        

    
        
    }];
    
    
    
    
    
}

@end
