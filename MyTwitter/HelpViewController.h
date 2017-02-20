//
//  HelpViewController.h
//  MyTwitter
//
//  Created by Mohini on 17/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TWITTER_WIKI_URL @"https://en.wikipedia.org/wiki/Twitter"

@interface HelpViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webViewContent;

@end
