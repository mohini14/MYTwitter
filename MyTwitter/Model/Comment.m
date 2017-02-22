//
// Created by Mohini on 21/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import "Comment.h"
#import "User.h"
#import "DateUtils.h"


@implementation Comment {

}

- (instancetype) initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self && dictionary)
    {

        self.comment = dictionary[@"comment"];
        self.createdAt = [DateUtils iso8601toDate:dictionary[@"created_at"]];
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.likes = dictionary[@"likes"];
        self.commentId =dictionary[@"id"];

        return self;
    } else{
        return nil;
    }
}



@end