//
//  MKPointArray.m
//  Basic
//
//  Created by mikazheng on 2022/2/22.
//  Copyright © 2022 zhengmiaokai. All rights reserved.
//

#import "MKPointArray.h"

@interface MKPointArray ()

@property (nonatomic, strong) NSPointerArray* pointArray; // NSMutableArray

@end

@implementation MKPointArray

- (instancetype)init {
    self = [super init];
    if (self) {
        self.pointArray = [[NSPointerArray alloc] initWithOptions:NSPointerFunctionsStrongMemory];
        /* self.pointArray = [NSPointerArray strongObjectsPointerArray]; */
    }
    return self;
}

- (instancetype)initWithOptions:(NSPointerFunctionsOptions)options {
    self = [super init];
    if (self) {
        self.pointArray = [[NSPointerArray alloc] initWithOptions:options];
    }
    return self;
}

- (void)addObject:(id)object {
    if (object) {
        [_pointArray addPointer:(__bridge  void*)object];
    }
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    if (object && (index < _pointArray.count)) {
        [_pointArray insertPointer:(__bridge  void*)object atIndex:index];
    }
}

- (NSUInteger)indexForObject:(id)object {
    for (NSUInteger index = 0; index<_pointArray.count; index++) {
        id temp = [_pointArray pointerAtIndex:index];
        if (temp == object) {
            return index;
        }
    }
    return 0;
}

- (id)objectAtIndex:(NSUInteger)index {
    if (index < _pointArray.count) {
        return (__bridge id)[_pointArray pointerAtIndex:index];
    }
    return nil;
}

- (void)removeAtIndex:(NSUInteger)index {
    if (index < _pointArray.count) {
        [_pointArray removePointerAtIndex:index];
    }
}

- (void)removeAllObjects {
    for (NSUInteger index = 0; index<_pointArray.count; index++) {
        [_pointArray removePointerAtIndex:index];
    }
}

@end
