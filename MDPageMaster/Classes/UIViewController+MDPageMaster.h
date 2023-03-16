//
//  UIViewController+MDPageMaster.h
//  MDPageMaster
//
//  Created by zitao0206 on 2018/5/4.
//

#import <UIKit/UIKit.h>
@class MDUrlAction;

@interface UIViewController (MDPageMaster)
/**
 Data transfer by this method
 */
- (void)handleWithURLAction:(MDUrlAction *)urlAction;
/**
 Whether unique in the stack, default YES unique in the stack.
 */
+ (BOOL)isSingleton;

@end
