//
//  MDUrlAction.h
//  MDPageMaster
//
//  Created by Leon on 2018/5/4.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MDSingletonType) {
    
    /*******默认值，单例模式下为SingletonTypeRetop，非单例模式下为NoSingletonTypeDefault ****/
    MDNoSingletonTypeNone = 0,
    
    /**** 单例页面：isSingleton方法默认为YES ****/
    MDSingletonTypeRetop,//栈中已有时，popTo此vc，例如首页vc
    MDSingletonTypeReuse,//栈中已有时，移动此vc到栈顶，例如登录页
    MDSingletonTypeRenew,//栈中已有时，去除栈中vc再push新vc，例如camera页
    
    /**** 非单例页面：须重写isSingleton方法为NO ****/
    MDNoSingletonTypeDefault,//vc可以循环进栈
    MDNoSingletonTypeRetop,//栈中已有时，popTo此vc
    MDNoSingletonTypeReuse,//栈中已有时，移动此vc到栈顶
    MDNoSingletonTypeRenew//栈中已有时，去除栈中vc再push新vc，例如WebViewVC
};

typedef NSInteger MDNaviAnimation;
#define MDNaviAnimationNone         -1 // 没有动画，不支持自定义Transition
#define MDNaviAnimationPush          0 // 标准的导航压入动画，不支持自定义Transition
#define MDNaviAnimationTransition    1 // 禁掉原生导航动画，支持自定义Transition

typedef void(^CallBack)(id result);

@interface MDNaviTransition : NSObject
@property (nonatomic, assign) MDNaviAnimation animation;
@property (nonatomic, strong) CATransition  *transition;

@end

@interface MDUrlAction : NSObject

@property (nonatomic, strong, readonly) NSURL *url;
/**
 单例类型，默认为SingletonTypeRetop
 */
@property (nonatomic, assign) MDSingletonType singletonType;
/**
 系统的导航动画
 */
@property (nonatomic, assign) MDNaviAnimation animation;
/**
 导航动画
 支持 CATransition
 */
@property (nonatomic, strong) MDNaviTransition *naviTransition;
/**
 回调block
 */
@property (nonatomic, strong) CallBack callBack;

+ (id)actionWithURL:(NSURL *)url;
+ (id)actionWithURLString:(NSString *)urlString;
- (id)initWithURL:(NSURL *)url;
- (id)initWithURLString:(NSString *)urlString;

- (void)setBool:(BOOL)boolValue forKey:(NSString *)key;
- (void)setInteger:(NSInteger)intValue forKey:(NSString *)key;
- (void)setDouble:(double)doubleValue forKey:(NSString *)key;
- (void)setString:(NSString *)string forKey:(NSString *)key;
/**
 如果参数不为3中基本类型，可以使用anyObject进行传递
 anyObject不支持在URL中进行传递
 */
- (void)setAnyObject:(id)object forKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
/**
 如果参数不为4中基本类型，可以使用anyObject进行传递
 anyObject不支持在URL中进行传递
 */
- (id)anyObjectForKey:(NSString *)key;
@end
