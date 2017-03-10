//
//  ZKPayMediator.m
//  Pods
//
//  Created by Kaiser on 2017/3/9.
//
//

#import "ZKPayMediator.h"
#import <objc/runtime.h>

@interface ZKPayMediator ()

@property (nonatomic, strong) NSMutableDictionary *cachedTarget;

@end

@implementation ZKPayMediator

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ZKPayMediator *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget {
    if (!targetName || !actionName) {
        return nil;
    }
    
    NSObject *target = self.cachedTarget[targetName];
    if (target == nil) {
        target = [[NSClassFromString(targetName) alloc] init];
    }
    
    SEL action = NSSelectorFromString(actionName);
    if (!target || !action) {
        return nil;
    }
    
    if (shouldCacheTarget) {
        self.cachedTarget[targetName] = target;
    }
    
    if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    }
    
    return nil;
}

- (void)releaseCachedTargetWithTargetName:(NSString *)targetName {
    if (!targetName) {
        return;
    }
    
    [self.cachedTarget removeObjectForKey:targetName];
}

#pragma mark - getters and setters

- (NSMutableDictionary *)cachedTarget {
    if (!_cachedTarget) {
        _cachedTarget = [NSMutableDictionary dictionary];
    }
    
    return _cachedTarget;
}

@end
