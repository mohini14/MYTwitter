//
// Created by Mohini on 21/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DateUtils : NSObject

+ (NSDate *)iso8601toDate:(NSString *)dateSTR;
+(NSString*)Datetoiso8601 :(NSDate *)date;
@end
