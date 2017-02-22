//
//  ActivityBar.m
//  MyTwitter
//
//  Created by Mohini on 18/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import "ActivityBar.h"

@interface ActivityBar ()

@end

@implementation ActivityBar

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+(void)activityBarOn :(UIViewController *)vc{
UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
[spinner setCenter:CGPointMake(160,124)];
[vc.view addSubview:spinner];
[spinner startAnimating];
    
}
@end
