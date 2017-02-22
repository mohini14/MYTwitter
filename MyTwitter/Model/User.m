//
// Created by Mohini on 21/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import "User.h"
#import "NSString+Utils.h"

@implementation User {

}
+ (User *)initWithDictionary:(NSDictionary *)dictionary {
    if(dictionary != nil) {
        User *user = [User new];
        user.firstName = dictionary[@"first_name"];
        user.lastName = dictionary[@"last_name"];
        user.username = dictionary[@"username"];
        user.email = dictionary[@"email"];
        user.displayName = [user.firstName append:[@" " append:user.lastName]];

        return user;
    } else {
        return nil;
    }
}

@end