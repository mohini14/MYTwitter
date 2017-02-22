//
// Created by Mohini on 21/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import "User.h"
#import "NSString+Utils.h"

@implementation User {

}

- (instancetype) initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self && dictionary)
    {
        self.firstName = dictionary[@"first_name"];
        self.lastName = dictionary[@"last_name"];
        self.username = dictionary[@"username"];
        self.email = dictionary[@"email"];
        self.displayName = [self.firstName append:[@" " append:self.lastName]];

        return self;
    } else {
        return nil;
    }
}

@end