//
// Created by Mohini on 17/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import "UserServices.h"
#import "NSString+Utils.h"
#import "Post.h"


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

+(void)getAllPost :(void (^)(BOOL isSuccess, NSArray *posts,NSString *errorMessage))callBackFromUserProfile{


    NSString *urlString=[HOST append:ALL_POSTS];

    [HTTPServices GETWithURL:urlString withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        BOOL isSuccess = false;
        NSDictionary *responseData;
        NSString *errorMessage = nil;
        NSMutableArray *posts = [@[] mutableCopy];
		if(error !=nil || [(NSHTTPURLResponse *)response statusCode]>=500){
            errorMessage=@"Server error";

        }else{
			NSError *error;
            responseData =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            if(error != nil ){
                errorMessage = error.description;
            }else{
                if([(NSHTTPURLResponse *)response statusCode]==200){
					isSuccess = true;
					for(NSDictionary *obj in responseData[@"results"]){
                        Post *p = [Post initWithDictionary:obj];
                        [posts addObject:p];
                    }
					
                }else{
                    errorMessage = responseData[@"error"];
                }
            }

        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *immutablePosts = [posts copy];
            callBackFromUserProfile(isSuccess, immutablePosts ,errorMessage);

        });


    }];
    
}

+(void)submitPost:(NSString *)post withUsername:(NSString *)username andCallBackMethod:(void (^)(BOOL isSuccess,NSDictionary *data,NSString *errorMessage))callBackFromUserpost
{
    NSDictionary *dict=@{
            @"post":post
    };
    
    NSString *urlString=[[HOST append:NEW_POST_URL]stringByReplacingOccurrencesOfString:@"<username>" withString:username];//replacing username from url
    [HTTPServices POSTWithURL:urlString andWithDictionary:dict andWithCompletionHAndler:^(NSData *data,NSURLResponse *response,NSError *error){
        
        [self passresponse:data withResponse:response withError:error andCompletionHandler:callBackFromUserpost];
        
    }];
}

+(void) getPostForPostID:(NSString *)postId andCallBackMethod:(void (^)(BOOL isSuccess,NSArray *data,NSString *errorMessage))callBackFromCommentVC
{

		NSString *urlString=[[HOST append:GET_POST_URL]stringByReplacingOccurrencesOfString:@"<post_id>"withString:postId];
		[HTTPServices GETWithURL:urlString withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		
			BOOL isSuccess=false;
			NSString *errorMessage=nil;
			NSDictionary *responsedata;
			NSMutableArray *postForPostId=[@[]mutableCopy];
			
			
			if(error!=nil && [(NSHTTPURLResponse *)response statusCode]>=500){//detecting server error
				errorMessage=@"SERVER ERROR";
				responsedata=nil;
			}else{
				NSError *error;
				responsedata=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
				if(error!=nil){
					errorMessage=error.description;
				}else{
					if([(NSHTTPURLResponse*) response statusCode]==200){
						isSuccess=true;
						for(NSDictionary *obj in responsedata[@"result"][@"comments"]){
							Comment *c=[Comment initWithDictionary:obj];
							[postForPostId addObject:c];
							
						}
					}else{
						errorMessage=responsedata[@"error"];
					}
				}
				
				
			}
			
			
			dispatch_async(dispatch_get_main_queue(), ^{
				NSArray *immutableArray=[postForPostId copy];
				callBackFromCommentVC(isSuccess,immutableArray,errorMessage);
				
			});
		
		}];
}


//for adding comment to a post
+(void) addComment :(NSString*)comment withPostID:(NSString *)postId withUserName:(NSString *)userName  andCallBackMethod:(void (^)(BOOL isSuccess,NSDictionary *data,NSString *errorMessage))callBackFromCommentVC{
    
    NSDictionary *dict=@{
                         @"comment":comment
                         };
    
    NSString *urlString=[[[HOST append:ADD_COMMENT_WITH_POST_ID]stringByReplacingOccurrencesOfString:@"<username>" withString:userName]stringByReplacingOccurrencesOfString:@"<post id>" withString:postId];
    [HTTPServices POSTWithURL:urlString andWithDictionary:dict andWithCompletionHAndler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [self passresponse:data withResponse:response withError:error andCompletionHandler:callBackFromCommentVC];
        
    }];
}@end
