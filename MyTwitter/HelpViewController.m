//
//  HelpViewController.m
//  MyTwitter
//
//  Created by Mohini on 17/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.activityIndicator=[ActivityIndicator getInstanceForView:self];
	NSString *urlString=TWITTER_WIKI_URL;
	[self.activityIndicator startActivityIndicator];
	self.webViewContent.opaque = NO;
	self.webViewContent.backgroundColor = [UIColor clearColor];
	NSURL *url=[NSURL URLWithString:urlString];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	
	[self.webViewContent loadRequest:urlRequest];
	[self.activityIndicator stopActivityIndicator];
	

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

@end
