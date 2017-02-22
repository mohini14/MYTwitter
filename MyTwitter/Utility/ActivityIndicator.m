//
//  ActivityIndicator.m
//  MyTwitter
//
//  Created by Mohini on 20/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import "ActivityIndicator.h"

@implementation ActivityIndicator

+(instancetype)getInstance{
    static ActivityIndicator *instance=nil;
    @synchronized (self) {
        if(instance==nil){
            instance=[ActivityIndicator new];
            instance.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            instance.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            instance.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            instance.activityIndicator.center = instance.overlayView.center;

            instance.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 250.0, 400.0, 80.0)];
            instance.lblTitle.textAlignment = NSTextAlignmentCenter;
            instance.lblTitle.textColor = [UIColor whiteColor];
            instance.lblTitle.alpha = 1.0;
            instance.lblTitle.backgroundColor = [UIColor clearColor];
            instance.lblTitle.numberOfLines = 1;
			//instance.overlayView = [[UIView alloc] initWithFrame:screenRect];

            instance.overlayView.opaque = NO;
			instance.overlayView.backgroundColor = [UIColor darkGrayColor];
			instance.overlayView.alpha = 0.5;
            [instance.overlayView addSubview:instance.activityIndicator];
            [instance.overlayView addSubview:instance.lblTitle];

        }
        
    }
    return instance;
    
}


+(instancetype)getInstanceForView:(UIViewController *)viewController{
    ActivityIndicator *instance=[ActivityIndicator getInstance];
    instance.viewController=viewController;
    return instance;
}

-(void)startActivityIndicatorWithMessage:(NSString *)msg{

    self.lblTitle.text = msg;
    [_overlayView addSubview:_lblTitle];
    [self.activityIndicator startAnimating];
    [self.viewController.view addSubview:self.overlayView];
}

-(void)startActivityIndicator {
    self.lblTitle.text = nil;
    [_overlayView addSubview:_lblTitle];
    [self.activityIndicator startAnimating];
    [self.viewController.view addSubview:self.overlayView];
}

-(void)stopActivityIndicator{
    [self.activityIndicator stopAnimating];
    [self.overlayView removeFromSuperview];

}

@end
