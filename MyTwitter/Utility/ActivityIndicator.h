//
//  ActivityIndicator.h
//  MyTwitter
//
//  Created by Mohini on 20/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ActivityIndicator : NSObject

@property(nonatomic, strong) UIViewController *viewController;

@property(nonatomic, strong) UIView *overlayView;

@property(nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic,strong) UILabel *lblTitle;

+ (instancetype)getInstance;

+ (instancetype)getInstanceForView:(UIViewController *)viewController;

- (void)startActivityIndicatorWithMessage:(NSString *)msg;

- (void)startActivityIndicator;


- (void)stopActivityIndicator;

@end
