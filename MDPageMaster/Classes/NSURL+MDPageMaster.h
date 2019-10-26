//
//  NSURL+MDPageMaster.h
//  MDPageMaster
//
//  Created by lizitao on 18/5/4.
//  Copyright © 2018年 lizitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (MDPageMaster)

/**
 将query解析为NSDictionary
 @return 返回参数字典对象，参数的值已经进行了decode.
 */
- (NSDictionary *)parseQuery;

@end
