//
//  NSURL+MDPageMaster.h
//  MDPageMaster
//
//  Created by zitao0206 on 18/5/4.
//

#import <Foundation/Foundation.h>

@interface NSURL (MDPageMaster)

/**
 Parse query to NSDictionary
  @return returns a dictionary object with the values of the parameters decoded.
 */
- (NSDictionary *)parseQuery;

@end
