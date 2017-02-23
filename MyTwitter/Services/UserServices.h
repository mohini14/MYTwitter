//
// Created by Mohini on 17/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPServices.h"
#import "Post.h"
#import "Comment.h"
#import "User.h"
#define HOST   @"http://ec2-52-38-49-62.us-west-2.compute.amazonaws.com:8000/mytwitter"
//#define HOST @"http://03a99d4b.ngrok.io/mytwitter"
#define LOGIN_URL @"/user/login"
#define REG_URL @"/user/"
#define ALL_POSTS @"/post"
#define NEW_POST_URL @"/user/<username>/post"
#define GET_POST_URL @"/post/<post_id>"
#define ADD_COMMENT_WITH_POST_ID @"/user/<username>/post/<post id>/comment"
#define EDIT_COMMENT_URL @"/comment/id"

#define RESULT_KEY @"result"
#define RESULTS_KEY @"results"
#define ERROR_KEY @"error"



typedef void(^CallBackToMainVC) (BOOL isSuccess,NSDictionary *dict,NSString * errorMessage);

@interface UserServices : NSObject

+(void)login:(NSString *)username andPassword:(NSString *)password andCompletionHandler:(void (^)(User *, NSString *))callBackFromVC;

+(void) register:(NSDictionary *)dict andCallBackMethod:(void (^)(User *, NSString *))callBackFromVC;
+(void)passresponse:(NSData *)data withResponse:(NSURLResponse *)response withError:(NSError *)error andCompletionHandler :(CallBackToMainVC )callBackFromVC;
+(void)getAllPost :(void (^)(NSArray *, NSString *))callBackFromUserProfile;
+(void)submitPost:(NSString *)post withUsername:(NSString *)username andCallBackMethod:(void (^)(Post *, NSString *))callBackFromUserpost;;
+(void) getPostForPostID:(NSString *)postId andCallBackMethod:(void (^)(Post *, NSString *))callBackFromCommentVC;
+(void) addComment :(NSString*)comment withPostID:(NSString *)postId withUserName:(NSString *)userName  andCallBackMethod:(void (^)(BOOL, NSString *))callBackFromCommentVC;
+(void)updatePost :(NSString *)updatedPost withPostId:(NSString *)postId andWithCallBAckMethod:(void (^)(BOOL isSuccess,NSString *errorMessage))callBackFromPostVc;
+(void) DeletePost :(NSString *)postId andWithCallBAckMethod:(void (^)(BOOL isSuccess,NSString *errorMessage))callBackFromPostVc;
+(void) deleteComment :(NSString *)commentId andWithCallBAckMethod:(void (^)(BOOL isSuccess,NSString *errorMessage))callBackFromCommentVc;
+(void)updateComment :(NSString *)updatedComment withPostId:(NSString *)postId andWithCallBAckMethod:(void (^)(BOOL isSuccess,NSString *errorMessage))callBackFromCommentVc;

@end

