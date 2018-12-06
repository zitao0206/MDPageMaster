//
//  XYUrlAction.h
//  XYPageMaster
//
//  Created by lizitao on 2018/5/4.
//

#import <Foundation/Foundation.h>
#import "XYReactBlackBoard.h"

typedef NS_ENUM(NSInteger, XYSingletonType) {
    
    /*******默认值，单例模式下为XYSingletonTypeRetop，非单例模式下为XYNoSingletonTypeDefault ****/
    XYNoSingletonTypeNone = 0,
    
    /**** 单例页面：isSingleton方法默认为YES ****/
    XYSingletonTypeRetop,//栈中已有时，popTo此vc，例如首页vc
    XYSingletonTypeReuse,//栈中已有时，移动此vc到栈顶，例如登录页
    XYSingletonTypeRenew,//栈中已有时，去除栈中vc再push新vc，例如camera页
    
    /**** 非单例页面：须重写isSingleton方法为NO ****/
    XYNoSingletonTypeDefault,//vc可以循环进栈
    XYNoSingletonTypeRetop,//栈中已有时，popTo此vc
    XYNoSingletonTypeReuse,//栈中已有时，移动此vc到栈顶
    XYNoSingletonTypeRenew//栈中已有时，去除栈中vc再push新vc，例如XYWebViewVC
};

typedef NSInteger XYNaviAnimation;
#define XYNaviAnimationNone         -1 // 没有动画，不支持自定义Transition
#define XYNaviAnimationPush          0 // 标准的导航压入动画，不支持自定义Transition
#define XYNaviAnimationTransition    1 // 禁掉原生导航动画，支持自定义Transition

typedef void(^CallBack)(id result);

@interface XYNaviTransition : NSObject
@property (nonatomic, assign) XYNaviAnimation animation;
@property (nonatomic, strong) CATransition  *transition;

@end

@interface XYUrlAction : NSObject

@property (nonatomic, strong, readonly) NSURL *url;
/**
 单例类型，默认为XYSingletonTypeRetop
 */
@property (nonatomic, assign) XYSingletonType singletonType;
/**
 系统的导航动画
 */
@property (nonatomic, assign) XYNaviAnimation animation;
/**
 导航动画
 支持 CATransition
 */
@property (nonatomic, strong) XYNaviTransition *naviTransition;
/**
 回调block
 */
@property (nonatomic, strong) CallBack callBack;
/**
 数据的正反向传递黑板；
 */
@property (nonatomic, strong) XYReactBlackBoard *callBackBoard;

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
