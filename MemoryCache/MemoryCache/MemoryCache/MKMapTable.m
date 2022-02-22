//
//  MKMapTable.m
//  Basic
//
//  Created by mikazheng on 2022/2/22.
//  Copyright © 2022 zhengmiaokai. All rights reserved.
//

#import "MKMapTable.h"

@interface MKMapTable ()

@property (nonatomic, strong) NSMapTable* mapTable; // NSMutableDictionary

@end

@implementation MKMapTable

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mapTable = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory capacity:0];
        /* self.mapTable = [NSMapTable strongToStrongObjectsMapTable]; */
    }
    return self;
}

- (instancetype)initWithKeyOptions:(NSPointerFunctionsOptions)keyOptions valueOptions:(NSPointerFunctionsOptions)valueOptions {
    self = [super init];
    if (self) {
        self.mapTable = [[NSMapTable alloc] initWithKeyOptions:keyOptions valueOptions:valueOptions capacity:0];
    }
    return self;
}

- (void)setObject:(id)object forKey:(NSString *)key {
    if (object && key) {
        [_mapTable setObject:object forKey:key];
    }
}

- (id)objectForKey:(NSString *)key {
    if (key) {
        return [_mapTable objectForKey:key];
    }
    return nil;
}

- (void)removeObjectForKey:(NSString *)key {
    if (key) {
        [_mapTable removeObjectForKey:key];
    }
}

- (void)removeAllObjects {
    [_mapTable removeAllObjects];
}

@end
