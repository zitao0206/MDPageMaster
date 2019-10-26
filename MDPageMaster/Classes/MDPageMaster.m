//
//  MDPageMaster.m
//  MDPageMaster
//
//  Created by lizitao on 2018/5/4.
//

#import "MDPageMaster.h"

@interface MDPageMaster ()
@property (nonatomic, strong) MDPageMasterNavigationController *rootNavigationController;
@property (nonatomic, strong) NSString *urlScheme;
@property (nonatomic, strong) NSString *fileNamesOfURLMapping;
@property (nonatomic, strong) NSString *rootVCName;
@property (nonatomic, strong) NSString *rootVC_SB;
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSArray *>*urlMapping;
@end

@implementation MDPageMaster

static MDPageMaster *master;
static dispatch_once_t onceToken;
@synthesize urlScheme = _urlScheme;
@synthesize fileNamesOfURLMapping = _fileNamesOfURLMapping;

+ (instancetype)master
{
    return [[self alloc] init];
}

- (id)init
{
    if (self = [super init]) {
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    dispatch_once(&onceToken, ^{
        master = [super allocWithZone:zone];
    });
    return master;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    return master;
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone
{
    return master;
}

- (void)setFileNamesOfURLMapping:(NSString *)fileName
{
    _fileNamesOfURLMapping = fileName;
    [self loadViewControllerElements];
}

- (void)setupNavigationControllerWithParams:(NSDictionary *)params
{
    //eg: params = @{@"schema":@"xiaoying",@"pagesFile":@"urlmapping",@"rootVC":@"HomeTabViewController",@"mainBundle":@"Main"};
    if (!params) return;
    self.urlScheme = [params objectForKey:@"schema"];
    if (self.urlScheme.length < 1) return;
    self.fileNamesOfURLMapping = [params objectForKey:@"pagesFile"];
    if (self.fileNamesOfURLMapping.length < 1) return;
    self.rootVCName = [params objectForKey:@"rootVC"];
    if (self.rootVCName.length < 1) return;
    //storyboard信息
    self.rootVC_SB = [params objectForKey:@"rootVC_SB"];
    [self setupRootNavigationController];
}

- (void)setupRootNavigationController
{
    if (!self.rootNavigationController) {
        UIViewController *homeViewController = nil;
        if (self.rootVC_SB.length > 0) {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:self.rootVC_SB bundle:nil];
            homeViewController = [storyBoard instantiateViewControllerWithIdentifier:self.rootVCName];
        } else {
            homeViewController = [[NSClassFromString(self.rootVCName) alloc]init];
        }
        _rootNavigationController = [[MDPageMasterNavigationController alloc] initWithRootViewController:homeViewController];
    }
    [[MDPageMaster master] setNavigationController:self.rootNavigationController];
}

- (void)resetNavigationController
{
     self.rootNavigationController = nil;
     [self setupRootNavigationController];
     [[MDPageMaster master] setNavigationController:self.rootNavigationController];
}

- (void)setNavigationController:(MDPageMasterNavigationController *)navigationContorller
{
    _navigationContorller = navigationContorller;
}

- (NSMutableDictionary *)loadViewControllerElements
{
    if (_urlMapping) {
        [_urlMapping removeAllObjects];
    } else {
        _urlMapping = [NSMutableDictionary dictionary];
    }
    
    NSString *fileName = self.fileNamesOfURLMapping;
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    if (content) {
        NSArray *eachLine = [content componentsSeparatedByString:@"\n"];
        for (NSString *aString in eachLine) {
            if (aString.length < 1) {
                NSLog(@"空行");
                continue;
            }
            NSString *lineString = [aString stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (lineString.length < 1) {
                //空行
                continue;
            }
            NSRange commentRange = [lineString rangeOfString:@"#"];
            if (commentRange.location == 0) {
                // #在开头，表明这一行是注释
                continue;
            }
            if (commentRange.location != NSNotFound) {
                //其后有注释，需要去除后面的注释
                lineString = [lineString substringToIndex:commentRange.location];
            }
            NSRange tabRange = [lineString rangeOfString:@"\t"];
            BOOL isContainTabT = NO;
            if (tabRange.location != NSNotFound) {
                isContainTabT = YES;
                //过滤文本编辑器中\t\t\t\t\t
                lineString = [lineString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            }
            if ([lineString rangeOfString:@":"].location != NSNotFound) {
                NSString *omitString = [lineString stringByReplacingOccurrencesOfString:@" " withString:@""];
                NSArray *kv = [omitString componentsSeparatedByString:@":"];
                //key值一律字母小写
                if (kv.count == 2) {
                    NSString *host = [kv[0] lowercaseString];
                    NSArray *array = [NSArray arrayWithObjects:kv[1],nil];
                    [_urlMapping setObject:array forKey:host];
                }
                if (kv.count == 3) {
                    NSString *host = [kv[0] lowercaseString];
                    NSArray *array = [NSArray arrayWithObjects:kv[1], kv[2], nil];
                    [_urlMapping setObject:array forKey:host];
                }
                if (kv.count == 4) {
                    NSString *host = [kv[0] lowercaseString];
                    NSArray *array = [NSArray arrayWithObjects:kv[1], kv[2], kv[3], nil];
                    [_urlMapping setObject:array forKey:host];
                }
            }
        }
    } else {
        NSLog(@"[url mapping error] file(%@) is empty!!!!", fileName);
    }
    return _urlMapping;
}

- (void)openURLAction:(MDUrlAction *)urlAction result:(void(^)(NSString *viewController))result
{
    if (![urlAction isKindOfClass:[MDUrlAction class]]) return;
    NSString *viewController = [self obtainClassFromURLAction:urlAction];
    if (result) {
        result(viewController);
    }
}

- (void)openUrl:(NSString *)url action:(void(^)(MDUrlAction *action))actionBlock
{
    if (url.length <= 0) return;
    MDUrlAction *action = [MDUrlAction actionWithURL:[NSURL URLWithString:url]];
    if (actionBlock) {
        actionBlock(action);
    }
    if (!self.navigationContorller) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self handleOpenURLAction:action];
    });
}

- (void)openURLAction:(MDUrlAction *)urlAction
{
    if (![urlAction isKindOfClass:[MDUrlAction class]]) return;
    if (!self.navigationContorller) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self handleOpenURLAction:urlAction];
    });
}

- (UIViewController *)handleOpenURLAction:(MDUrlAction *)urlAction
{
    return [self obtainControllerURLAction:urlAction];
}

- (UIViewController *)obtainControllerURLAction:(MDUrlAction *)urlAction
{
    UIViewController *controller = nil;
    
    NSString *key = [self obtainKeyFromURLAction:urlAction];
    if (key.length < 1) return nil;
    NSArray *array = [_urlMapping objectForKey:key];
   
    //storyboard跳转，默认mainBundle中
    if (array.count == 2) {
        NSString *storyboardName = array.lastObject;
        if (storyboardName.length > 0) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
            NSString *class = [self obtainClassFromURLAction:urlAction];
            if (class.length < 1) return nil;
            controller = [storyboard instantiateViewControllerWithIdentifier:class];
        }
    }
    //storyboard跳转，自定义Bundle中
    if (array.count == 3) {
        NSString *storyboardName = array[1];
        NSString *bundleName = array.lastObject;;
        if (storyboardName.length > 0 && bundleName.length > 0) {
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
            NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
            NSString *class = [self obtainClassFromURLAction:urlAction];
            if (class.length < 1) return nil;
            controller = [storyboard instantiateViewControllerWithIdentifier:class];
        }
    }
    //非storyboard
    if (array.count == 1) {
        NSString *class = [self obtainClassFromURLAction:urlAction];
        controller = [NSClassFromString(class) new];
    }
    
    if (!controller) return nil;
    BOOL isSingleton = NO;
    if ([[controller class] respondsToSelector:@selector(isSingleton)]) {
        //根据此VC方法来区分是否单例页面
        isSingleton = [[controller class] isSingleton];
    }
    if (isSingleton) {
        [self openSingletonViewController:controller withURLAction:urlAction];
    } else {
        [self openNoSingletonViewController:controller withURLAction:urlAction];
    }
    return controller;
}

- (NSString *)obtainClassFromURLAction:(MDUrlAction *)urlAction
{
    if (urlAction.url.host.length < 1) return nil;
    NSString *class = nil;
    NSArray *array = [_urlMapping objectForKey:[urlAction.url.host lowercaseString]];
    if (array.count >= 1) {
        class = array.firstObject;
    }
    if (class.length < 1) return nil;
    return class;
}

- (NSString *)obtainKeyFromURLAction:(MDUrlAction *)urlAction
{
    NSString *key = [urlAction.url.host lowercaseString];
    if (key.length < 1) return nil;
    return key;
}

- (BOOL)checkUrlIsRegistered:(NSURL *)url
{
    if (!url) return NO;
    if (![url.scheme isEqualToString:_urlScheme]) return NO;
    if (url.host.length > 0) {
        if ([_urlMapping objectForKey:url.host]) {
            return YES;
        }
    }
    return NO;
}

- (void)pushViewController:(UIViewController *)controller withURLAction:(MDUrlAction *)urlAction
{
    if ([controller respondsToSelector:@selector(handleWithURLAction:)]) {
        [controller handleWithURLAction:urlAction];
    }
    if (!urlAction.naviTransition) {
        [self.navigationContorller pushViewController:controller withAnimation:urlAction.animation == MDNaviAnimationPush];
    } else {
        [self.navigationContorller pushViewController:controller withTransition:urlAction.naviTransition];
    }
}

- (void)openNoSingletonViewController:(UIViewController *)controller withURLAction:(MDUrlAction *)urlAction
{
    if (!controller) return;
    if (urlAction.singletonType == MDNoSingletonTypeNone) {
        urlAction.singletonType = MDNoSingletonTypeDefault;
    }
    if (!(urlAction.singletonType == MDNoSingletonTypeDefault ||
          urlAction.singletonType == MDNoSingletonTypeRenew   ||
          urlAction.singletonType == MDNoSingletonTypeRetop   ||
          urlAction.singletonType == MDNoSingletonTypeReuse)) {
        return;//如果业务上层配置错误，将跳转不成功；
    }
    MDSingletonType singletonType = urlAction.singletonType;
    if (singletonType == MDNoSingletonTypeDefault) {
        [self pushViewController:controller withURLAction:urlAction];
    } else {
        NSArray<UIViewController *> *viewControllers = self.navigationContorller.viewControllers;
        if ([viewControllers.lastObject isKindOfClass:[controller class]]) {
            //NoSingletonTypeRetop和NoSingletonTypeReuse
            if (urlAction.singletonType != MDNoSingletonTypeRenew) {
                return; //已在栈顶
            }
        }
        NSInteger kCount = [viewControllers count];
        NSInteger i = 0;
        for (i = kCount - 1; i >= 0; i--) {
            UIViewController *viewController = [viewControllers objectAtIndex:i];
            if ([viewController isKindOfClass:[controller class]]) {
                //在栈里找到了
                if (urlAction.singletonType == MDNoSingletonTypeReuse || urlAction.singletonType == MDNoSingletonTypeRenew) {
                    NSRange belowRange = NSMakeRange(0, i);
                    NSArray <UIViewController *>*belowArray = [viewControllers subarrayWithRange:belowRange];
                    NSRange topRange = NSMakeRange(i + 1, kCount - i - 1);
                    NSArray <UIViewController *>*topArray = [viewControllers subarrayWithRange:topRange];
                    UIViewController *obj = [viewControllers objectAtIndex:i];
                    NSMutableArray <UIViewController *>*stacks = [NSMutableArray arrayWithArray:belowArray];
                    [stacks addObjectsFromArray:topArray];
                    
                    if (urlAction.singletonType == MDNoSingletonTypeReuse) {
                        //Reuse，不需要再调handleWithURLAction:
                        [stacks addObject:obj];
                        if (urlAction.naviTransition != nil) {
                            [self.navigationContorller.view.layer addAnimation:urlAction.naviTransition.transition forKey:kCATransition];
                        } else {
                            CATransition *transition = [self defaultTransiton];
                            [self.navigationContorller.view.layer addAnimation:transition forKey:kCATransition];
                        }
                        [self.navigationContorller setViewControllers:stacks animated:NO];
                        
                    } else {
                        //Renew，需要再调handleWithURLAction:
                        [self.navigationContorller setViewControllers:stacks animated:NO];
                        if ([controller respondsToSelector:@selector(handleWithURLAction:)]) {
                            [controller handleWithURLAction:urlAction];
                        }
                        if (urlAction.naviTransition != nil) {
                            [self.navigationContorller pushViewController:controller withTransition:urlAction.naviTransition];
                        } else {
                            CATransition *transition = [self defaultTransiton];
                            [self.navigationContorller.view.layer addAnimation:transition forKey:kCATransition];
                            [self.navigationContorller pushViewController:controller animated:NO];
                        }
                    }
                    
                } else {
                    //Retop，不需要再调handleWithURLAction:
                    MDNaviAnimation animation = MDNaviAnimationNone;
                    animation = urlAction.animation;
                    [self.navigationContorller popToViewController:viewController withTransition:urlAction.naviTransition];
                }
                return;
            }
        }
        //在栈里没找到，直接push一份
        if (i < 0) {
            [self pushViewController:controller withURLAction:urlAction];
        }
    }
}

- (void)openSingletonViewController:(UIViewController *)controller withURLAction:(MDUrlAction *)urlAction
{
    if (!controller) return;
    if (urlAction.singletonType == MDNoSingletonTypeNone) {
        urlAction.singletonType = MDSingletonTypeRetop;
    }
    if (!(urlAction.singletonType == MDSingletonTypeRetop ||
        urlAction.singletonType == MDSingletonTypeReuse ||
        urlAction.singletonType == MDSingletonTypeRenew)) {
        return;//如果业务上层配置错误，将跳转不成功；
    }
    NSArray<UIViewController *> *viewControllers = self.navigationContorller.viewControllers;
    if ([viewControllers.lastObject isKindOfClass:[controller class]]) {
        //SingletonTypeRetop和SingletonTypeReuse
        if (urlAction.singletonType != MDSingletonTypeRenew) {
            return;
        }
    }
    NSInteger kCount = [viewControllers count];
    NSInteger i = 0;
    for (i = kCount - 1; i >= 0; i--) {
        UIViewController *viewController = [viewControllers objectAtIndex:i];
        if ([viewController isKindOfClass:[controller class]]) {
            //在栈里找到了
            if (urlAction.singletonType == MDSingletonTypeReuse || urlAction.singletonType == MDSingletonTypeRenew) {
                NSRange belowRange = NSMakeRange(0, i);
                NSArray <UIViewController *>*belowArray = [viewControllers subarrayWithRange:belowRange];
                NSRange topRange = NSMakeRange(i + 1, kCount - i - 1);
                NSArray <UIViewController *>*topArray = [viewControllers subarrayWithRange:topRange];
                UIViewController *obj = [viewControllers objectAtIndex:i];
                NSMutableArray <UIViewController *>*stacks = [NSMutableArray arrayWithArray:belowArray];
                [stacks addObjectsFromArray:topArray];
                if (urlAction.singletonType == MDSingletonTypeReuse) {
                    //Reuse，不需要再调handleWithURLAction:
                    [stacks addObject:obj];
                    if (urlAction.naviTransition != nil) {
                        [self.navigationContorller.view.layer addAnimation:urlAction.naviTransition.transition forKey:kCATransition];
                    } else {
                        CATransition *transition = [self defaultTransiton];
                        [self.navigationContorller.view.layer addAnimation:transition forKey:kCATransition];
                    }
                    [self.navigationContorller setViewControllers:stacks animated:NO];
                    
                } else {
                    //Renew，需要再调handleWithURLAction:
                    [self.navigationContorller setViewControllers:stacks animated:NO];
                    if (urlAction.naviTransition != nil) {
                        [self.navigationContorller pushViewController:controller withTransition:urlAction.naviTransition];
                    } else {
                        if ([controller respondsToSelector:@selector(handleWithURLAction:)]) {
                            [controller handleWithURLAction:urlAction];
                        }
                        CATransition *transition = [self defaultTransiton];
                        [self.navigationContorller.view.layer addAnimation:transition forKey:kCATransition];
                        [self.navigationContorller pushViewController:controller animated:NO];
                    }
                }
           
            } else {
                //Retop，不需要再调handleWithURLAction:
                MDNaviAnimation animation = MDNaviAnimationNone;
                animation = urlAction.animation;
                [self.navigationContorller popToViewController:viewController withTransition:urlAction.naviTransition];
            }
            return;
        }
    }
    //在栈里没找到
    if (i < 0) {
        [self pushViewController:controller withURLAction:urlAction];
    }
}

- (CATransition *)defaultTransiton
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionMoveIn;            //改变视图控制器出现的方式
    transition.subtype = kCATransitionFromTop;     //出现的位置
    transition.duration = 0.3;
    return transition;
}

@end
