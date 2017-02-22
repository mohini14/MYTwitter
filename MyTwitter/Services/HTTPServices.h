//
// Created by Mohini on 17/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HTTPServices : NSObject

typedef void (^CompletionHandelerBlock)(NSInteger statusCode,NSDictionary *responseData,NSString *errorMessage);

+(void) GETWithURL:(NSString *)urlString withCompletionHandler:(void (^)(NSInteger, NSDictionary *, NSString *))completionHandlerCallBack;
+(void) POSTWithURL:(NSString *)urlString andWithDictionary:(NSDictionary * )dict andWithCompletionHAndler:(void (^)(NSInteger, NSDictionary *, NSString *))completionHandlerCallBack;
+(void)handleResponse :(NSData *)data withResponse:(NSURLResponse *)response withError:(NSError *)error;



@end