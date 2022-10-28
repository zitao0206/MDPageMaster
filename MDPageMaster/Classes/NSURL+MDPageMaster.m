//
//  NSURL+MDPageMaster.m
//  MDPageMaster
//
//  Created by Leon on 18/5/4.
//  Copyright © 2018年 Leon. All rights reserved.
//

#import "NSURL+MDPageMaster.h"

@implementation NSURL (MDPageMaster)

- (NSDictionary *)parseQuery
{
    NSString *query = [self query];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
		if ([elements count] <= 1) {
			continue;
		}
        NSString *key = [[elements objectAtIndex:0] stringByRemovingPercentEncoding];
        CFStringRef originValue = CFURLCreateStringByReplacingPercentEscapes(NULL, (CFStringRef)([elements objectAtIndex:1]),  CFSTR(""));
        NSString *oriValue = (__bridge NSString*)originValue;
        NSAssert(oriValue != nil, @"url is invalid");
        if (oriValue) {
            [dict setObject:oriValue forKey:key];
        }
        CFRelease(originValue);
    }
    return dict;
}

@end
