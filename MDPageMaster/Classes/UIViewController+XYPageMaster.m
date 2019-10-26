//
//  UIViewController+XYPageMaster.m
//  XYPageMaster
//
//  Created by lizitao on 2018/5/4.
//

#import "UIViewController+XYPageMaster.h"

@implementation UIViewController (XYPageMaster)

+ (BOOL)isSingleton
{
    //考虑到VivaVideo中大部分页面都是栈中唯一的，因此设为YES；子类可重写设为NO，例如Webview
    return YES;
}

- (void)handleWithURLAction:(XYUrlAction *)urlAction
{
    
}

@end
