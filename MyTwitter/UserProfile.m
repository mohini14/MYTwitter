//
//  UserProfile.m
//  MyTwitter
//
//  Created by Mohini on 18/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import "UserProfile.h"

@interface UserProfile ()

@end

@implementation UserProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameLabel.text= _dict[@"name"];
    _emailIdLabel.text= _dict[@"email"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)unwindFromUserPost:(UIStoryboardSegue *)segue{
    
}

@end
