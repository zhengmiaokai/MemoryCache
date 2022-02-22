//
//  MKMapTable.h
//  Basic
//
//  Created by mikazheng on 2022/2/22.
//  Copyright © 2022 zhengmiaokai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMapTable : NSObject

/* 默认：强引用-强引用 */
- (instancetype)init;

/* NSPointerFunctionsStrongMemory、NSPointerFunctionsWeakMemory */
- (instancetype)initWithKeyOptions:(NSPointerFunctionsOptions)keyOptions valueOptions:(NSPointerFunctionsOptions)valueOptions;


- (void)setObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;
- (void)removeAllObjects;

@end

NS_ASSUME_NONNULL_END
