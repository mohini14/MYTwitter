//
// Created by Mohini on 21/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;


@interface Comment : NSObject



@property  NSString *comment;
@property  NSNumber *likes;
@property NSDate *createdAt;
@property User *user;
@property NSNumber *commentId;

+(Comment *)initWithDictionary:(NSDictionary *)dictionary;


@end