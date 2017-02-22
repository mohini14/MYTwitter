//
// Created by Mohini on 21/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import "Post.h"
#import "User.h"
#import "DateUtils.h"


@implementation Post {

}
+ (Post *)initWithDictionary:(NSDictionary *)dictionary {
    if(dictionary!=nil) {
        Post *post = [Post new];
        post.post = dictionary[@"post"];
        post.createdAt = [DateUtils iso8601toDate:dictionary[@"created_at"]];
        post.likes = dictionary[@"likes"];
        post.postId = dictionary[@"id"];
        post.user = [User initWithDictionary:dictionary[@"user"]];
        return post;
    }else{
        return nil;
    }
}

@end