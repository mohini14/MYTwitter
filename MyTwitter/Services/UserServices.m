//
// Created by Mohini on 17/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import "UserServices.h"
#import "NSString+Utils.h"



@implementation UserServices {

}

+(void)login:(NSString *)username andPassword:(NSString *)password andCompletionHandler:(void (^)(User *user ,NSString *errorMsg))callBackFromVC{

    NSMutableDictionary *dict=[NSMutableDictionary new];//making dictionary for the purpose of sending.
    dict[@"username"]=username;
    dict[@"password"]=password;
    NSString *urlString=[NSString stringWithFormat:@"%@%@",HOST,LOGIN_URL];
    [HTTPServices POSTWithURL:urlString andWithDictionary:dict andWithCompletionHAndler:^(NSInteger statusCode,NSDictionary *responseData,NSString *errorMessage) {
        User *user = nil;
        NSString *errorMsg=nil;
        if(statusCode==200){
            user= [[User alloc] initWithDictionary:responseData[RESULT_KEY]];
        }else {
           errorMsg= errorMessage == nil ? responseData[ERROR_KEY] : errorMessage;
            //true when have to show api error
        }
        dispatch_async(dispatch_get_main_queue(), ^(){
            callBackFromVC(user,errorMsg );
        });

    }];
}


+(void) register:(NSDictionary *)dict andCallBackMethod:(void (^)(User *user ,NSString *errorMsg))callBackFromVC{

    NSString *urlString=[NSString stringWithFormat:@"%@%@",HOST,REG_URL];
    [HTTPServices POSTWithURL:urlString andWithDictionary:dict andWithCompletionHAndler:^(NSInteger statusCode,NSDictionary *responseData,NSString *errorMessage) {
        User *user = nil;
        NSString *errorMsg=nil;
        if(statusCode==200){
            user= [[User alloc] initWithDictionary:responseData[RESULT_KEY]];
        }
        else {
            errorMsg = errorMessage == nil ? responseData[ERROR_KEY] : errorMessage;
        }//true when have to show api error
        dispatch_async(dispatch_get_main_queue(), ^(){
            callBackFromVC(user,errorMsg );
        });
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

+(void)getAllPost :(void (^)(NSArray *posts, NSString *errorMessage))callBackFromUserProfile{


    NSString *urlString=[HOST append:ALL_POSTS];

    [HTTPServices GETWithURL:urlString withCompletionHandler:^(NSInteger statusCode,NSDictionary *responseData,NSString *errorMessage) {
        NSMutableArray *posts = [[NSMutableArray alloc] init];
        NSString *errorMsg=nil;
        if(statusCode==200){
            for(NSDictionary *obj in responseData[RESULTS_KEY]){
                Post *p = [[Post alloc] initWithDictionary:obj];
                [posts addObject:p];
            }
        }else{
            errorMsg = errorMessage == nil ? responseData[ERROR_KEY] : errorMessage;  //true when have to show api error
        }
        dispatch_async(dispatch_get_main_queue(), ^(){
            callBackFromUserProfile(posts,errorMsg );
        });
    }];

}

+(void)submitPost:(NSString *)post withUsername:(NSString *)username andCallBackMethod:(void (^)(Post *post,NSString *errorMessage))callBackFromPost
{
    NSDictionary *dict=@{
            @"post":post
    };
    
    NSString *urlString=[[HOST append:NEW_POST_URL]stringByReplacingOccurrencesOfString:@"<username>" withString:username];//replacing username from url
    [HTTPServices POSTWithURL:urlString andWithDictionary:dict andWithCompletionHAndler:^(NSInteger statusCode,NSDictionary *responseData,NSString *errorMessage){
        Post *post = nil;
        NSString *errorMsg=nil;
        if(statusCode==200){
            post= [[Post alloc] initWithDictionary:responseData[RESULT_KEY]];
        }else {
            errorMsg = errorMessage == nil ? responseData[ERROR_KEY] : errorMessage;
        }//true when have to show api error
        dispatch_async(dispatch_get_main_queue(), ^(){
            callBackFromPost(post,errorMsg );
        });

        
    }];
}

+(void) getPostForPostID:(NSString *)postId andCallBackMethod:(void (^)(Post *post,NSString *errorMessage))callBackFromCommentVC
{

		NSString *urlString=[[HOST append:GET_POST_URL]stringByReplacingOccurrencesOfString:@"<post_id>"withString:postId];
		[HTTPServices GETWithURL:urlString withCompletionHandler:^(NSInteger statusCode,NSDictionary *responseData,NSString *errorMessage) {
            NSString *errorMsg=nil;
            Post *p;
            if(statusCode==200){
                p = [[Post alloc] initWithDictionary:responseData[RESULT_KEY]];

            }else{
                errorMsg = errorMessage == nil ? responseData[ERROR_KEY] : errorMessage;  //true when have to show api error
            }
            dispatch_async(dispatch_get_main_queue(), ^(){
                callBackFromCommentVC(p,errorMsg );
            });
        }];
}


//for adding comment to a post
+(void) addComment :(NSString*)comment withPostID:(NSString *)postId withUserName:(NSString *)userName  andCallBackMethod:(void (^)(BOOL isSuccess,NSString *errorMessage))callBackFromCommentVC{
    
    NSDictionary *dict=@{
                         @"comment":comment
                         };
    
    NSString *urlString=[[[HOST append:ADD_COMMENT_WITH_POST_ID]stringByReplacingOccurrencesOfString:@"<username>" withString:userName]stringByReplacingOccurrencesOfString:@"<post id>" withString:postId];
    [HTTPServices POSTWithURL:urlString andWithDictionary:dict andWithCompletionHAndler:^(NSInteger statusCode,NSDictionary *responseData,NSString *errorMessage){
        NSString *errorMsg=nil;
        BOOL isSuccess=false;
        if(statusCode==200){
            isSuccess=true;
        }else {
            errorMsg = errorMessage == nil ? responseData[ERROR_KEY] : errorMessage;
        }//true when have to show api error
        dispatch_async(dispatch_get_main_queue(), ^(){
            callBackFromCommentVC(isSuccess,errorMsg );
        });

    }];
}


+(void)updatePost :(NSString *)updatedPost withPostId:(NSString *)postId andWithCallBAckMethod:(void (^)(BOOL isSuccess,NSString *errorMessage))callBackFromPostVc{
	NSDictionary *dict=@{
						 @"post":updatedPost
						 };

	NSString *urlString=[[HOST append:GET_POST_URL]stringByReplacingOccurrencesOfString:@"<post_id>" withString:postId];
	[HTTPServices PUTWithURL:urlString andWithDictionary:dict andWithCompletionHandler:^(NSInteger statusCode, NSDictionary *responseData, NSString *errorMessage) {
		NSString *errorMsg=nil;
		BOOL isSuccess=false;
		if(statusCode==200){
			isSuccess=true;
		}else {
			errorMsg = errorMessage == nil ? responseData[ERROR_KEY] : errorMessage;
		}//true when have to show api error
		dispatch_async(dispatch_get_main_queue(), ^(){
			callBackFromPostVc(isSuccess,errorMsg );
		});
		

		
	}];
	
}


+(void) DeletePost :(NSString *)postId andWithCallBAckMethod:(void (^)(BOOL isSuccess,NSString *errorMessage))callBackFromPostVc{
	
	NSString *urlString=[[HOST append:GET_POST_URL]stringByReplacingOccurrencesOfString:@"<post_id>" withString:postId];
	[HTTPServices DELETEWithURL:urlString withCompletionHandler:^(NSInteger statusCode, NSDictionary *responseData, NSString *errorMessage) {
		
		NSString *errorMsg=nil;
		BOOL isSuccess=false;
		if(statusCode==200){
			isSuccess=true;
		}else {
			errorMsg = errorMessage == nil ? responseData[ERROR_KEY] : errorMessage;
		}//true when have to show api error
		dispatch_async(dispatch_get_main_queue(), ^(){
			callBackFromPostVc(isSuccess,errorMsg );
		});
		
	}];
}


+(void) deleteComment :(NSString *)commentId andWithCallBAckMethod:(void (^)(BOOL isSuccess,NSString *errorMessage))callBackFromCommentVc{
	
	NSString *urlString=[[HOST append:EDIT_COMMENT_URL]stringByReplacingOccurrencesOfString:@"id" withString:commentId];
	[HTTPServices DELETEWithURL:urlString withCompletionHandler:^(NSInteger statusCode, NSDictionary *responseData, NSString *errorMessage) {
		
		NSString *errorMsg=nil;
		BOOL isSuccess=false;
		if(statusCode==200){
			isSuccess=true;
		}else {
			errorMsg = errorMessage == nil ? responseData[ERROR_KEY] : errorMessage;
		}//true when have to show api error
		dispatch_async(dispatch_get_main_queue(), ^(){
			callBackFromCommentVc(isSuccess,errorMsg );
		});
		
	}];
}


+(void)updateComment :(NSString *)updatedComment withPostId:(NSString *)postId andWithCallBAckMethod:(void (^)(BOOL isSuccess,NSString *errorMessage))callBackFromCommentVc{
	NSDictionary *dict=@{
						 @"comment":updatedComment
						 };
	
	NSString *urlString=[[HOST append:EDIT_COMMENT_URL]stringByReplacingOccurrencesOfString:@"id" withString:postId];
	[HTTPServices PUTWithURL:urlString andWithDictionary:dict andWithCompletionHandler:^(NSInteger statusCode, NSDictionary *responseData, NSString *errorMessage) {
		NSString *errorMsg=nil;
		BOOL isSuccess=false;
		if(statusCode==200){
			isSuccess=true;
		}else {
			errorMsg = errorMessage == nil ? responseData[ERROR_KEY] : errorMessage;
		}//true when have to show api error
		dispatch_async(dispatch_get_main_queue(), ^(){
			callBackFromCommentVc(isSuccess,errorMsg );
		});
		
		
		
	}];
	
}



@end
