//
//  MKMemoryCache.m
//  Basic
//
//  Created by mikazheng on 2022/2/22.
//  Copyright © 2022 zhengmiaokai. All rights reserved.
//

#import "MKMemoryCache.h"
#import <UIKit/UIKit.h>

// NSCache本身是线程安全
#define MCLOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
#define MCUNLOCK(lock) dispatch_semaphore_signal(lock);

@interface MKMemoryCache ()

@property (nonatomic, strong, nonnull) NSMapTable* weakCache; // strong-weak cache
@property (nonatomic, strong, nonnull) dispatch_semaphore_t lock; // a lock to keep the access to `weakCache` thread-safe

@end

@implementation MKMemoryCache

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        /* LFU + LRU
        self.totalCostLimit = 1024 * 1024 * 1024; // 限制内存大小（1GB）
        self.countLimit = 5000; // 限制key-value数量（5000）
         */
        
        self.weakCache = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory capacity:0];
        self.lock = dispatch_semaphore_create(1);
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMemoryWarning:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    return self;
}

- (void)didReceiveMemoryWarning:(NSNotification *)notification {
    [super removeAllObjects];
}

- (void)setObject:(id)obj forKey:(id)key {
    if (key && obj) {
        [super setObject:obj forKey:key];
        
        MCLOCK(self.lock);
        [self.weakCache setObject:obj forKey:key];
        MCUNLOCK(self.lock);
    }
}

- (id)objectForKey:(id)key {
    if (!key) return nil;
    
    id obj = [super objectForKey:key];
    if (!obj) {
        MCLOCK(self.lock);
        obj = [self.weakCache objectForKey:key];
        MCUNLOCK(self.lock);
        if (obj) {
            [super setObject:obj forKey:key];
        }
    }
    return obj;
}

- (void)removeObjectForKey:(id)key {
    if (key) {
        MCLOCK(self.lock);
        [self.weakCache removeObjectForKey:key];
        MCUNLOCK(self.lock);
        
        [super removeObjectForKey:key];
    }
}

- (void)removeAllObjects {
    MCLOCK(self.lock);
    [self.weakCache removeAllObjects];
    MCUNLOCK(self.lock);
    
    [super removeAllObjects];
}

@end
