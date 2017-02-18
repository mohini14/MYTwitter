//
// Created by Mohini on 17/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import "HTTPServices.h"


@implementation HTTPServices {





}


+(void) GETWithURL:(NSString *)urlString  withCompletionHandler:(void (^)(NSData *data,NSURLResponse *response,NSError *error))completionHandlerCallBack{


    NSURL *url=[NSURL URLWithString:urlString];
    NSURLSessionConfiguration * defaultSessionConfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession=[NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSURLSessionDataTask *dataTask=[defaultSession dataTaskWithURL:url completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        NSLog(@"HTTP GET LOG url:%@, data:%@, response:%@, error:%@", url.description, data.description, response.description, error.description);
        completionHandlerCallBack(data,response,error);
    }];
    [dataTask resume];

}


+(void) POSTWithURL:(NSString *)urlString andWithDictionary:(NSDictionary * )dict andWithCompletionHAndler:(void (^)(NSData *data,NSURLResponse *response,NSError *error))completionHandlerCallBack{


    NSURL *url=[NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    NSURLSessionConfiguration * defaultSessionConfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession=[NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSData * nsPostData=[NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];

    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:nsPostData];
    [urlRequest setValue:@"application/json:charset=UTF_8" forHTTPHeaderField:@"content-type"];
    NSURLSessionDataTask *dataTask= [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        NSLog(@"HTTP POST LOG url:%@, data:%@, response:%@, error:%@", url.description, data.description, response.description, error.description);
        completionHandlerCallBack(data,response,error);
    }];
    [dataTask resume];
}
@end
