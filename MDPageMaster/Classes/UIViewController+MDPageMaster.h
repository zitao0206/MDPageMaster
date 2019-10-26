//
//  UIViewController+MDPageMaster.h
//  MDPageMaster
//
//  Created by lizitao on 2018/5/4.
//

#import <UIKit/UIKit.h>
@class MDUrlAction;

@interface UIViewController (MDPageMaster)
/**
 通过此方法实现数据的正向传递
 */
- (void)handleWithURLAction:(MDUrlAction *)urlAction;
/**
 是否堆栈中唯一，默认YES堆栈中唯一。
 */
+ (BOOL)isSingleton;

@end
