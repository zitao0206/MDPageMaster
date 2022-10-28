//
//  MDUrlAction.m
//  MDPageMaster
//
//  Created by Leon on 2018/5/4.
//

#import "MDUrlAction.h"
#import "NSURL+MDPageMaster.h"
@interface MDUrlAction ()
@property (nonatomic, strong) NSMutableDictionary *params;
@end

@implementation MDUrlAction

- (id)initWithURL:(NSURL *)url
{
    if (self = [super init]) {
        _url = url;
        NSDictionary *dic = [url parseQuery];
        _params = [NSMutableDictionary dictionary];
        for (NSString *key in [dic allKeys]) {
            id value = [dic objectForKey:key];
            [_params setObject:value forKey:[key lowercaseString]];
        }
        _singletonType = MDNoSingletonTypeNone;
        if ([_params objectForKey:@"singletontype"]) {
            _singletonType = [[_params objectForKey:@"singletontype"] integerValue];
        }
        
    }
    return self;
}

+ (id)actionWithURL:(NSURL *)url
{
    if (![url isKindOfClass:[NSURL class]]) return nil;
    return [[MDUrlAction alloc] initWithURL:url];
}

+ (id)actionWithURLString:(NSString *)urlString
{
    if (![urlString isKindOfClass:[NSString class]]) return nil;
    return [[self alloc] initWithURLString:urlString];
}

- (id)initWithURLString:(NSString *)urlString
{
    if (![urlString isKindOfClass:[NSString class]]) return nil;
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (void)setBool:(BOOL)boolValue forKey:(NSString *)key
{
    [_params setObject:[NSNumber numberWithInteger:boolValue] forKey:[key lowercaseString]];
}

- (void)setInteger:(NSInteger)intValue forKey:(NSString *)key
{
    [_params setObject:[NSNumber numberWithInteger:intValue] forKey:[key lowercaseString]];
}

- (void)setDouble:(double)doubleValue forKey:(NSString *)key
{
    [_params setObject:[NSNumber numberWithDouble:doubleValue] forKey:[key lowercaseString]];
}

- (void)setString:(NSString *)string forKey:(NSString *)key
{
    if (![string isKindOfClass:[NSString class]]) return;
    if (string.length > 0) {
        [_params setObject:string forKey:[key lowercaseString]];
    }
}

- (void)setAnyObject:(id)object forKey:(NSString *)key
{
    if(object) {
        [_params setObject:object forKey:[key lowercaseString]];
    }
}

- (BOOL)boolForKey:(NSString *)key
{
    NSString *urlStr = [_params objectForKey:[key lowercaseString]];
    if(urlStr) {
        if ([urlStr isKindOfClass:[NSString class]]) {
            return [urlStr boolValue];
        }
        else if ([urlStr isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)urlStr boolValue];
        }
    }
    return NO;
}

- (NSInteger)integerForKey:(NSString *)key
{
    NSString *urlStr = [_params objectForKey:[key lowercaseString]];
    if(urlStr) {
        if ([urlStr isKindOfClass:[NSString class]]) {
            return [urlStr integerValue];
        }
        else if ([urlStr isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)urlStr integerValue];
        }
    }
    return 0;
}

- (double)doubleForKey:(NSString *)key
{
    NSString *urlStr = [_params objectForKey:[key lowercaseString]];
    if(urlStr) {
        if ([urlStr isKindOfClass:[NSString class]]) {
            return [urlStr doubleValue];
        }
        else if ([urlStr isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)urlStr doubleValue];
        }
    }
    return .0;
}

- (NSString *)stringForKey:(NSString *)key
{
    NSString *urlStr = [_params objectForKey:[key lowercaseString]];
    if(urlStr) {
        if ([urlStr isKindOfClass:[NSString class]]) {
            return urlStr;
        }
    }
    return nil;
}

- (id)anyObjectForKey:(NSString *)key
{
    return [_params objectForKey:[key lowercaseString]];
}

@end

@implementation MDNaviTransition

- (id)init
{
    if(self = [super init]) {
        //设置默认值
        _transition = [CATransition animation];
        _transition.type = kCATransitionPush;
        _transition.subtype = kCATransitionFromRight;
        _transition.duration = 0.3;
        _animation = MDNaviAnimationPush;
    }
    return self;
}

@end
