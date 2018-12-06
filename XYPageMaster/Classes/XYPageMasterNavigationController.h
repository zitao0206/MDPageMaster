//
//  XYPageMasterNavigationController.h
//  XYPageMaster
//
//  Created by lizitao on 2018/5/7.
//

#import <UIKit/UIKit.h>
#import "XYUrlAction.h"

@interface XYPageMasterNavigationController : UINavigationController

- (void)pushViewController:(UIViewController *)viewController withAnimation:(BOOL)animated;

- (void)popToViewController:(UIViewController *)viewController withAnimation:(BOOL)animated;

- (void)pushViewController:(UIViewController *)viewController withTransition:(XYNaviTransition *)naviTransition;

- (void)popToViewController:(UIViewController *)viewController withTransition:(XYNaviTransition *)naviTransition;

- (void)popCurrentViewControllerWithTransition:(XYNaviTransition *)naviTransition;

- (void)popToHomeViewControllerWithTransition:(XYNaviTransition *)naviTransition;

@end
