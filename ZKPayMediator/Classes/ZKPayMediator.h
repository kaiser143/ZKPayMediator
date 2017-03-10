//
//  ZKPayMediator.h
//  Pods
//
//  Created by Kaiser on 2017/3/9.
//
//

#import <Foundation/Foundation.h>

@interface ZKPayMediator : NSObject

+ (instancetype)sharedInstance;

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName;

@end
