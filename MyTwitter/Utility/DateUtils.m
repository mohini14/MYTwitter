//
// Created by Mohini on 21/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import "DateUtils.h"


@implementation DateUtils

+(NSDate *)iso8601toDate:(NSString *)dateSTR{
    NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
    NSDate *date = [formatter dateFromString:dateSTR];
    return  date;
}




@end