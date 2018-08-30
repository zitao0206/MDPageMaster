//
//  XYPageMasterLifeCycleModule.h
//  XYPageMaster
//
//  Created by lizitao on 18/5/4.
//  Copyright © 2018年 lizitao. All rights reserved.
//
//

#import "XYPageMasterLifeCycleModule.h"
#import "XYPageMaster.h"

@interface XYPageMasterLifeCycleModule()
@property (nonatomic, strong) NSDictionary *configuration;
@end


@implementation XYPageMasterLifeCycleModule

- (BOOL)loadModuleWithParams:(NSDictionary *)params
{
    self.configuration = [params mutableCopy];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   [[XYPageMaster master] setupNavigationControllerWithParams:self.configuration];
    return YES;
}

@end
