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
			//instance.overlayView = [[UIView alloc] initWithFrame:screenRect];
			instance.overlayView.opaque = NO;
			instance.overlayView.backgroundColor = [UIColor darkGrayColor];
			instance.overlayView.alpha = 0.5;

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




-(void) showLoadingViewMessage:(NSString *)msg
{
	
		
		self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 250.0, 400.0, 80.0)];
	
		_lblTitle.text = msg;
		_lblTitle.textAlignment = NSTextAlignmentCenter;
		_lblTitle.textColor = [UIColor whiteColor];
		_lblTitle.alpha = 1.0;
		_lblTitle.backgroundColor = [UIColor clearColor];
		_lblTitle.numberOfLines = 0;
	
	
		[_overlayView addSubview:_lblTitle];
		
		
		
	//	[self.viewController.view addSubview:_overlayView];
		
		
	
	
	
	
}

-(void)removeLoadedMessage{
	[_lblTitle removeFromSuperview];

	
}
-(void)stopActivityIndicator{
    [self.activityIndicator stopAnimating];
    [self.overlayView removeFromSuperview];

}

@end
