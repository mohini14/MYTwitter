//
// Created by Mohini on 17/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import "HTTPServices.h"


@implementation HTTPServices {





}


+(void) GETWithURL:(NSString *)urlString  withCompletionHandler:(void (^)(NSInteger statusCode,NSDictionary *responseData,NSString *errorMessage))completionHandlerCallBack{


    NSURL *url=[NSURL URLWithString:urlString];
    NSURLSessionConfiguration * defaultSessionConfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession=[NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSURLSessionDataTask *dataTask=[defaultSession dataTaskWithURL:url completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        NSLog(@"HTTP GET LOG url:%@, data:%@, response:%@, error:%@", url.description, data.description, response.description, error.description);
       [HTTPServices handleResponse:data withResponse:response withError:error withCompletionHandler:completionHandlerCallBack];

    }];
    [dataTask resume];

}




+(void) POSTWithURL:(NSString *)urlString andWithDictionary:(NSDictionary * )dict andWithCompletionHAndler:(void (^)(NSInteger statusCode,NSDictionary *responseData,NSString *errorMessage))completionHandlerCallBack{


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
        [HTTPServices handleResponse:data withResponse:response withError:error withCompletionHandler:completionHandlerCallBack];

    }];
    [dataTask resume];
}


+(void) PUTWithURL:(NSString *)urlString andWithDictionary:(NSDictionary *)dict andWithCompletionHandler:(void(^)(NSInteger statusCode,NSDictionary *responseData,NSString *errorMessage))CompletionHandlerCallBack{
	NSURL *url=[NSURL URLWithString:urlString];
	NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
	NSURLSessionConfiguration *defaultSessionConfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
	NSURLSession *defaultSession=[NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
	NSData *nsPutData=[NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
	[urlRequest setHTTPMethod:@"PUT"];
	[urlRequest setHTTPBody:nsPutData];
	[urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-Type"];
	NSURLSessionDataTask *dataTask=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * data, NSURLResponse *response, NSError *error) {
		 NSLog(@"HTTPPUT LOG url:%@, data:%@, response:%@, error:%@", url.description, data.description, response.description, error.description);
		[HTTPServices handleResponse:data withResponse:response withError:error withCompletionHandler:CompletionHandlerCallBack];
	}];
	[dataTask resume];
}





+(void) handleResponse :(NSData *)data withResponse:(NSURLResponse *)response withError:(NSError *)error withCompletionHandler:(CompletionHandelerBlock)completionHandlerCallBack{

    NSInteger status=0;
    NSString *errorMessage=nil;
    NSDictionary *responseData = nil;

    if(error!=nil ){//when unable to reach API i.e like internet connection not established
        status=-1;
        errorMessage=@"SERVER ERROR";
    }
    else{
        status = [(NSHTTPURLResponse *) response statusCode];
        NSError *err = nil;
        responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
        if(err != nil){
            errorMessage = @"Something Went Wrong";//when response is not parsable(JSON)
        }
    }

    completionHandlerCallBack(status,responseData,errorMessage);

}




+(void)DELETEWithURL :(NSString *)urlString  withCompletionHandler:(void (^)(NSInteger statusCode,NSDictionary *responseData,NSString *errorMessage))completionHandlerCallBack{
	
	
	NSURL *url=[NSURL URLWithString:urlString];
	NSURLSessionConfiguration * defaultSessionConfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
	NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
	NSURLSession *defaultSession=[NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
	[urlRequest setHTTPMethod:@"DELETE"];
	NSURLSessionDataTask *dataTask=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
		NSLog(@"HTTP GET LOG url:%@, data:%@, response:%@, error:%@", url.description, data.description, response.description, error.description);
		[HTTPServices handleResponse:data withResponse:response withError:error withCompletionHandler:completionHandlerCallBack];
		
	}];
	[dataTask resume];
	
}


@end
