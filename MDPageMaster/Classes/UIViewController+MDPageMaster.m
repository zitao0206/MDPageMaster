//
//  UIViewController+MDPageMaster.m
//  MDPageMaster
//
//  Created by zitao0206 on 2018/5/4.
//

#import "UIViewController+MDPageMaster.h"

@implementation UIViewController (MDPageMaster)

+ (BOOL)isSingleton
{
    //Considering that most pages are unique in the stack, it is set to YES; subclasses can be overridden to NO, e.g. Webview
    return YES;
}

- (void)handleWithURLAction:(MDUrlAction *)urlAction
{
    
}

@end
