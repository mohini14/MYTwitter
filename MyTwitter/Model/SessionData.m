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


@end