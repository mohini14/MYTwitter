//
// Created by Mohini on 21/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import "Post.h"
#import "User.h"
#import "DateUtils.h"
#import "Comment.h"


@implementation Post {

}

- (instancetype) initWithDictionary:(NSDictionary*)dictionary
{
	self = [super init];
	if (self && dictionary)
	{
        self.post = dictionary[@"post"];
        self.createdAt = [DateUtils iso8601toDate:dictionary[@"created_at"]];
        self.likes = dictionary[@"likes"];
        self.postId = dictionary[@"id"];
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        if(dictionary[@"comments"]!=nil) {
            NSMutableArray *temparr = [@[] mutableCopy];
            for (NSDictionary *dict in dictionary[@"comments"]) {
                Comment *c = [[Comment alloc] initWithDictionary:dict];
                [temparr addObject:c];
            }
            self.comments = temparr;
        }
        return self;
	} else
        return  nil;
}
@end
