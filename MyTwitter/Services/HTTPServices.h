//
// Created by Mohini on 17/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HTTPServices : NSObject

+(void) GETWithURL:(NSString *)urlString withCompletionHandler:(void (^)(NSData *data,NSURLResponse *response,NSError *error))completionHandlerCallBack;
+(void) POSTWithURL:(NSString *)urlString andWithDictionary:(NSDictionary * )dict andWithCompletionHAndler:(void (^)(NSData *data,NSURLResponse *response,NSError *error))completionHandlerCallBack;




@end