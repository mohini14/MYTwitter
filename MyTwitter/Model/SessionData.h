//
// Created by Mohini on 22/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@class Post;
#import "Comment.h"


@interface SessionData : NSObject

@property(nonatomic, strong) User *loggedInUser;

@property(nonatomic, strong) Post *currentPost;

@property(nonatomic, strong) Post *postToBeEdited;

@property(nonatomic, strong) NSString* userName;
@property(nonatomic, strong) NSString* password;

+(instancetype) getInstance;
@end
