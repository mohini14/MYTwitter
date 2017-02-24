//
// Created by Mohini on 22/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import "SessionData.h"
#import "User.h"
#import "Post.h"


@implementation SessionData {

}
+(instancetype)getInstance {
    static SessionData *sharedInstance=nil;
    if(sharedInstance!=nil){
        return sharedInstance;
    }else{
        @synchronized (self) {
            if(sharedInstance==nil){
                sharedInstance=[[SessionData alloc]init];

            }
        }
    }
    return sharedInstance;
}
- (instancetype)init
{
	self = [super init];
	if (self)
	{
		NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
		_userName=[defaults objectForKey:@"username"];
		_password=[defaults objectForKey:@"password"];

	}
	return self;
}

- (void)setUserName:(NSString *)userName
{
	_userName = userName;
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
	[defaults setValue:userName forKey:@"username"];
	[defaults synchronize];
}
@end
