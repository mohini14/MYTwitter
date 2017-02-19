//
// Created by Mohini on 17/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import "UserServices.h"


@implementation UserServices {

}

+(void)login:(NSString *)username andPassword:(NSString *)password andCompletionHandler:(void (^)(BOOL isSuccess,NSDictionary *dict,NSString * errorMessage))callBackFromVC{
    NSMutableDictionary *dict=[NSMutableDictionary new];
    dict[@"username"]=username;
    dict[@"password"]=password;
    NSString *urlString=[NSString stringWithFormat:@"%@%@",HOST,LOGIN_URL];
    
    
    [HTTPServices POSTWithURL:urlString andWithDictionary:dict andWithCompletionHAndler:^(NSData *data,NSURLResponse *response,NSError *error) {
        
        [self passresponse:data withResponse:response withError:error andCompletionHandler:callBackFromVC];
    }];
}


+(void) register:(NSDictionary *)dict andCallBackMethod:(void (^)(BOOL isSuccess,NSDictionary *data,NSString *errorMessage))callBackFromVC{

    NSString *urlString=[NSString stringWithFormat:@"%@%@",HOST,REG_URL];
    [HTTPServices POSTWithURL:urlString andWithDictionary:dict andWithCompletionHAndler:^(NSData *data,NSURLResponse *response,NSError *error){

        [self passresponse:data withResponse:response withError:error andCompletionHandler:callBackFromVC];

    }];
}

+(void)passresponse:(NSData *)data withResponse:(NSURLResponse *)response withError:(NSError *)error andCompletionHandler :(CallBackToMainVC )callBackFromVC{

        
        BOOL isSuccess;
        NSDictionary *responseData;
        NSString *errorMessage = nil;
        
        if(error !=nil || [(NSHTTPURLResponse *)response statusCode]>=500){
            isSuccess=false;
            responseData=nil;
            errorMessage=@"Server error";
            
        }else {
            
            responseData =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            if( [(NSHTTPURLResponse *)response statusCode]==200){         // http code for error
                isSuccess=true;
            }else{
                isSuccess=false;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            callBackFromVC(isSuccess, responseData,errorMessage);
            
        });
    



}

+(void)getAllPost :(void (^)(BOOL isSuccess,NSDictionary*data,NSString *errorMessage))callBackFromUserProfile{
    NSString *urlString=[NSString stringWithFormat:@"%@%@",HOST,ALL_POSTS];
    [HTTPServices GETWithURL:urlString withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self passresponse:data withResponse:response withError:error andCompletionHandler:callBackFromUserProfile];
    }];
    
}

+(void)submitPost:(NSString *)post withUsername:(NSString *)username andCallBackMethod:(void (^)(BOOL isSuccess,NSDictionary *data,NSString *errorMessage))callBackFromUserpost
{
    NSDictionary *dict=@{
            @"post":post
    };
    
    NSString *urlString=[[NSString stringWithFormat:@"%@%@",HOST,NEW_POST_URL]stringByReplacingOccurrencesOfString:@"<username>" withString:username];//replacing username from url
    [HTTPServices POSTWithURL:urlString andWithDictionary:dict andWithCompletionHAndler:^(NSData *data,NSURLResponse *response,NSError *error){
        
        [self passresponse:data withResponse:response withError:error andCompletionHandler:callBackFromUserpost];
        
    }];
}
@end
