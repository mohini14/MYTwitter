//
// Created by Mohini on 21/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"


@interface Post : NSObject

@property NSString *post;
@property NSNumber *likes;
@property NSDate *createdAt;
@property NSNumber *postId;
@property User *user;
@property NSArray *comments;//array because multiple comments


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end