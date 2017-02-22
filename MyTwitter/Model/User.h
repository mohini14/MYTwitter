//
// Created by Mohini on 21/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject

@property NSString *firstName;
@property NSString *lastName;
@property NSString *email;
@property NSString *username;
@property NSString *displayName;

+(User *)initWithDictionary:(NSDictionary *)dictionary;
@end