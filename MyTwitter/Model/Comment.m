//
// Created by Mohini on 21/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import "Comment.h"
#import "User.h"
#import "DateUtils.h"


@implementation Comment {

}

+(Comment *)initWithDictionary:(NSDictionary *)dictionary {
    if(dictionary!=nil) {
        Comment *comment = [Comment new];
        comment.comment = dictionary[@"comment"];
        comment.createdAt = [DateUtils iso8601toDate:dictionary[@"created_at"]];
        comment.user = [User initWithDictionary:dictionary[@"user"]];
        comment.likes = dictionary[@"likes"];
        comment.commentId =dictionary[@"id"];

        return comment;
    } else{
        return nil;
    }
}

@end