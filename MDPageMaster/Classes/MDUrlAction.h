//
//  MDUrlAction.h
//  MDPageMaster
//
//  Created by zitao0206 on 2018/5/4.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MDSingletonType) {
    
    /** The default value is SingletonTypeRetop in singleton mode and NoSingletonTypeDefault in non-singleton mode **/
    MDNoSingletonTypeNone = 0,
    
    /** Single example page: isSingleton method defaults to YES **/
    MDSingletonTypeRetop,//Already in the stack, pop To this vc, eg. Home Page
    MDSingletonTypeReuse,//Already in the stack，move it to the top, eg. Login Page
    MDSingletonTypeRenew,//Already in the stack，Remove it and push new vc, eg. camera Page
    
    /** Non-singleton pages: must override isSingleton method to NO **/
    MDNoSingletonTypeDefault,//VC can loop into the stack
    MDNoSingletonTypeRetop,//Already in the stack, pop To this vc
    MDNoSingletonTypeReuse,//栈中已有时，移动此vc到栈顶
    MDNoSingletonTypeRenew//Already in the stack，Remove it and push new vcWebViewVC
};

typedef NSInteger MDNaviAnimation;
#define MDNaviAnimationNone         -1 // No animation, no customization transition
#define MDNaviAnimationPush          0 // Standard navigation Push animation, no customization transition
#define MDNaviAnimationTransition    1 // Disable native navigation animations and support custom transitions

typedef void(^CallBack)(id result);

@interface MDNaviTransition : NSObject
@property (nonatomic, assign) MDNaviAnimation animation;
@property (nonatomic, strong) CATransition  *transition;

@end

@interface MDUrlAction : NSObject

@property (nonatomic, strong, readonly) NSURL *url;
/**
 Singleton type, default is SingletonTypeRetop
 */
@property (nonatomic, assign) MDSingletonType singletonType;
/**
 Navigation animation of the system
 */
@property (nonatomic, assign) MDNaviAnimation animation;
/**
 Navigation animation
 Support CATransition
 */
@property (nonatomic, strong) MDNaviTransition *naviTransition;
/**
 Callback block
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
 If the parameter is not a basic type, it can be passed using anyObject
  anyObject does not support passing in the URL
 */
- (void)setAnyObject:(id)object forKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
/**
 If the parameter is not a basic type, it can be passed using anyObject
  anyObject does not support passing in the URL
 */
- (id)anyObjectForKey:(NSString *)key;
@end
