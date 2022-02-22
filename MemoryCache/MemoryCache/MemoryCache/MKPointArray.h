//
//  MKPointArray.h
//  Basic
//
//  Created by mikazheng on 2022/2/22.
//  Copyright © 2022 zhengmiaokai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPointArray : NSObject

/* 默认：强引用 */
- (instancetype)init;

/* NSPointerFunctionsStrongMemory、NSPointerFunctionsWeakMemory */
- (instancetype)initWithOptions:(NSPointerFunctionsOptions)options;

- (void)addObject:(id)object;
- (void)insertObject:(id)object atIndex:(NSUInteger)index;

- (NSUInteger)indexForObject:(id)object;
- (id)objectAtIndex:(NSUInteger)index;

- (void)removeAtIndex:(NSUInteger)index;
- (void)removeAllObjects;

@end

NS_ASSUME_NONNULL_END
