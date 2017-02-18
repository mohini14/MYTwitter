//
// Created by Mohini on 18/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<UIKit/UIKit.h>


@interface AlertManager : NSObject

+ (void)showAlertPopupWithTitle:(NSString *)title andMessage:(NSString *)message andActionTitle:(NSString *)actionTitle forView:(UIViewController *)view;

+ (BOOL)validateEmail:(NSString *)inputText ;

@end
