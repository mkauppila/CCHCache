//
//  ViewController.m
//  ExampleApp
//
//  Created by Markus Kauppila on 05/12/14.
//
//

#import "ViewController.h"

#import "CCHCache.h"

@interface ViewController ()

@property (nonatomic, strong) CCHDiskCache *cache;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.cache = [[CCHDiskCache alloc] initWithSize:5000000 withName:@"number-cache"];
    [self.cache setObject:@1001 forKey:@"one" withCompletion:^(NSString *key, id <NSCopying> value) {
        NSLog(@"set value %@ for key %@", value, key);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.cache objectForKey:@"one" withCompletion:^(NSString *key, id <NSCopying> value) {
        NSLog(@"%@: %@", key, value);
    }];

    [self.cache removeObjectForKey:@"one" withCompletion:^(NSString *key, id <NSCopying> value) {
        NSLog(@"Deleted key %@ of value %@", key, value);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
