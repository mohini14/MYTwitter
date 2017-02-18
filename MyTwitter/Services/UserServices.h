//
// Created by Mohini on 17/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPServices.h"
//#define HOST   @"http://ec2-52-38-49-62.us-west-2.compute.amazonaws.com:8000/mytwitter"
#define HOST @"http://03a99d4b.ngrok.io/mytwitter"
#define LOGIN_URL @"/user/login"
#define REG_URL @"/user"
#define ALL_POSTS @"/post"



typedef void(^CallBackToMainVC) (BOOL isSuccess,NSDictionary *dict,NSString * errorMessage);

@interface UserServices : NSObject

+(void)login:(NSString *)username andPassword:(NSString *)password andCompletionHandler:(void (^)(BOOL isSuccess,NSDictionary *dict,NSString * errorMessage))callBackFromVC;

+(void) register:(NSDictionary *)dict andCallBackMethod:(void (^)(BOOL isSuccess,NSDictionary *data,NSString *error))callBackFromVC;
+(void)passresponse:(NSData *)data withResponse:(NSURLResponse *)response withError:(NSError *)error andCompletionHandler :(CallBackToMainVC )callBackFromVC;
+(void)getAllPost :(void (^)(BOOL isSuccess,NSDictionary*data,NSString *errorMessage))callBackFromUserProfile;




@end

