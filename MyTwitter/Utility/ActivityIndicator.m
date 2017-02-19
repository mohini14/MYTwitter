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

        }
        
    }
    return instance;
    
}


+(instancetype)getInstanceForView:(UIViewController *)viewController{
    ActivityIndicator *instance=[ActivityIndicator getInstance];
    instance.viewController=viewController;
    return instance;
}

-(void)startActivityIndicator{




    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.viewController.view addSubview:self.overlayView];
}

-(void)stopActivityIndicator{
    [self.activityIndicator stopAnimating];
    [self.overlayView removeFromSuperview];

}

@end
