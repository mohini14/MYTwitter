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

+(NSString*)Datetoiso8601 :(NSDate *)date{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
	[dateFormatter setLocale:enUSPOSIXLocale];
	[dateFormatter setDateFormat:@"dd-MM-yyy"   "HH:mm:ss"];
	
	NSDate *now = [NSDate date];
	NSString *iso8601String = [dateFormatter stringFromDate:now];

	return iso8601String;
}



@end
