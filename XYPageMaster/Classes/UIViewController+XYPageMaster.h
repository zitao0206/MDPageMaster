//
//  UIViewController+XYPageMaster.h
//  XYPageMaster
//
//  Created by lizitao on 2018/5/4.
//

#import <UIKit/UIKit.h>
@class XYUrlAction;

@interface UIViewController (XYPageMaster)
/**
 通过此方法实现数据的正向传递
 */
- (void)handleWithURLAction:(XYUrlAction *)urlAction;
/**
 是否堆栈中唯一，默认YES堆栈中唯一。
 */
+ (BOOL)isSingleton;

@end
