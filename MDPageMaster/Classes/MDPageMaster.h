//
//  MDPageMaster.h
//  MDPageMaster
//
//  Created by zitao0206 on 2018/5/4.
//

#import <Foundation/Foundation.h>
#import "MDUrlAction.h"
#import "UIViewController+MDPageMaster.h"
#import "MDPageMasterNavigationController.h"
#import "MDPageMasterViewController.h"

@interface MDPageMaster : NSObject
/**
 The main navigation controller of app. All VC operations should be based on it.
 */
@property (nonatomic, strong, readonly) MDPageMasterNavigationController * _Nullable navigationContorller;
/**
 Initialization of pageMaster, global singleton
 */
+ (nonnull instancetype)master;
/**
 Set the main navigation controller of the default program
 All page jumps will be performed in the navigationContoller.
 eg: params = @{@"schema":@"weixin",@"pagesFile":@"urlmapping",@"rootVC":@"HomeTabBarVC",@"rootVC_SB":@"Main"};
 */
- (void)setupNavigationControllerWithParams:(nonnull NSDictionary *)params;
/**
 Reset the main navigation controller
 All page jumps will be performed in the navigationContoller;
 */
- (void)resetNavigationController;
/**
 Main navigation controller of setup program
 All page jumps will be carried out in the navigationContoller. Use with caution!!!
 */
- (void)setNavigationController:(nonnull MDPageMasterNavigationController *)navigationContorller;
/**
 This method will complete url parsing, parameter transfer and jump.
 */
- (void)openURLAction:(nonnull MDUrlAction *)urlAction;
/**
 This method will complete url parsing, parameter transfer, jump, and block callback.
 */
- (void)openUrl:(nonnull NSString *)url action:(void(^)(MDUrlAction * _Nullable action))actionBlock;
/**
 This method will only help you complete the url parsing and return class.
 The parameter transfer and jump business are implemented by themselves.
 */
- (void)openURLAction:(nonnull MDUrlAction *)urlAction result:(nonnull void(^)(NSString * _Nullable vc))result;
/**
 Check whether the page url has been registered in urlmapping;
 */
- (BOOL)checkUrlIsRegistered:(nonnull NSURL *)url;

@end
