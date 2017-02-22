//
// Created by Mohini on 18/02/17.
// Copyright (c) 2017 Mohini. All rights reserved.
//

#import "NSString+Utils.h"


@implementation NSString (Utils)
- (NSString *)trim {

    NSString *trimmedString = [self stringByTrimmingCharactersInSet: [NSCharacterSet punctuationCharacterSet]];

    return trimmedString;

}

-(BOOL)isempty{
    
    if(self==nil){
        return true;
    }
    else{
       return  [[self trim]isEqualToString:@""];
    }
    return false;
}

- (NSString *)append:(NSString *)appendString {
    NSString *appendedString=[NSString stringWithFormat:@"%@%@",self,appendString];
    return appendedString;
}



@end
