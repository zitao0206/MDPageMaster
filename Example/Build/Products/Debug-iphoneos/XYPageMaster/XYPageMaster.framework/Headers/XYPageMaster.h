//
//  XYPageMaster.h
//  XYPageMaster
//
//  Created by lizitao on 2018/5/4.
//

#import <Foundation/Foundation.h>
#import "XYUrlAction.h"
#import "UIViewController+XYPageMaster.h"
#import "XYPageMasterNavigationController.h"
#import "XYPageMasterViewController.h"

@interface XYPageMaster : NSObject
/**
 app的主导航控制器，所有的VC操作应基于它。
 */
@property (nonatomic, strong, readonly) XYPageMasterNavigationController * _Nullable navigationContorller;
/**
 pageMaster的初始化，全局单例
 */
+ (nonnull instancetype)master;
/**
 设置默认程序的主导航控制器
 的页面跳转都会在navigationContorller中进行；
 eg: params = @{@"schema":@"xiaoying",@"pagesFile":@"urlmapping",@"rootVC":@"XYHomeTabBarVC",@"rootVC_SB":@"Main"};
 */
- (void)setupNavigationControllerWithParams:(nonnull NSDictionary *)params;
/**
 重置主导航控制器
 的页面跳转都会在navigationContorller中进行；
 */
- (void)resetNavigationController;
/**
 设置程序的主导航控制器
 的页面跳转都会在navigationContorller中进行，业务慎用！！！
 */
- (void)setNavigationController:(nonnull XYPageMasterNavigationController *)navigationContorller;
/**
 此方法会完成url解析、参数传递、跳转；
 */
- (void)openURLAction:(nonnull XYUrlAction *)urlAction;
/**
 此方法会完成url解析、参数传递、跳转，带block回调；
 */
- (void)openUrl:(nonnull NSString *)url action:(nonnull void(^)(XYUrlAction * _Nullable action))actionBlock;
/**
 此方法只会帮你完成url解析，返回class；
 参数传递、跳转业务自己实现；
 */
- (void)openURLAction:(nonnull XYUrlAction *)urlAction result:(nonnull void(^)(NSString * _Nullable vc))result;
/**
  检查页面url是否已经在urlmapping中注册；
   YES：在，NO：不在
 */
- (BOOL)checkUrlIsRegistered:(nonnull NSURL *)url;

@end
