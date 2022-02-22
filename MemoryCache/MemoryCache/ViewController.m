//
//  ViewController.m
//  MemoryCache
//
//  Created by mikazheng on 2022/2/22.
//

#import "ViewController.h"
#import "MemoryCache/MKPointArray.h"
#import "MemoryCache/MKMapTable.h"
#import "MemoryCache/MKMemoryCache.h"

@interface ViewController () <NSCacheDelegate>

@property(nonatomic, strong) MKPointArray* strongArray;
@property(nonatomic, strong) MKMapTable* strongDic;

@property (nonatomic, strong) MKMemoryCache* memoryCache;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    /* ============================================================= */
    MKPointArray* strongArray = [[MKPointArray alloc] init];
    [strongArray addObject:[NSObject new]];
    self.strongArray = strongArray;
    
    MKPointArray* weakArray = [[MKPointArray alloc] initWithOptions:NSPointerFunctionsWeakMemory];
    [weakArray addObject:[strongArray objectAtIndex:0]];
    
    /* ------------------------------------------------------------- */
    MKMapTable* strongDic = [[MKMapTable alloc] init];
    [strongDic setObject:[NSObject new] forKey:@"number"];
    self.strongDic = strongDic;
    
    MKMapTable* weakDic = [[MKMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory];
    [weakDic setObject:[strongDic objectForKey:@"number"] forKey:@"number"];
    
    /* ------------------------------------------------------------- */
    NSLog(@"strongArry: %@\nstrongDic: %@", [strongArray objectAtIndex:0], [strongDic objectForKey:@"number"]);
    // strongArry: <NSObject: 0x6000016a84a0> strongDic: <NSObject: 0x6000016a8470>
    
    NSLog(@"weakArry: %@\nweakDic: %@", [weakArray objectAtIndex:0], [weakDic objectForKey:@"number"]);
    // weakArry: (null) weakDic: (null)
    
    [strongDic removeAllObjects];
    [strongArray removeAllObjects];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"after_weakArry: %@\nafter_weakDic: %@", [weakArray objectAtIndex:0], [weakDic objectForKey:@"number"]);
        // weakArry: (null) weakDic: (null)
    });
    
    /* ============================================================= */
    MKMemoryCache* memoryCache = [[MKMemoryCache alloc] init];
    memoryCache.countLimit = 200;
    self.memoryCache = memoryCache;
    
    for (int i=0; i<400; i++) {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"abc" ofType:@"jpeg"];
        UIImage* image = [UIImage imageWithContentsOfFile:path];
        [memoryCache setObject:image forKey:[NSString stringWithFormat:@"key_%d", i]];
    }
    
    /* ------------------------------------------------------------- */
    NSLog(@"memoryCache_199: %@", [memoryCache objectForKey:@"key_199"]); // memoryCache_199: (null)
    NSLog(@"memoryCache_399: %@", [memoryCache objectForKey:@"key_399"]); // memoryCache_399: <UIImage:0x6000008857a0 anonymous {3072, 1275} renderingMode=automatic>
}

@end
