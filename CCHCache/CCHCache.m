//
//  CCHCache.m
//  CCHCache
//
//  Created by Markus Kauppila on 05/12/14.
//
//

#import "CCHCache.h"

@interface CCHCache ()

@property (nonatomic, assign, readonly) NSUInteger memoryCacheSizeInBytes;
@property (nonatomic, assign, readonly) NSUInteger diskCacheSizeInBytes;

@property (nonatomic, strong, readonly) CCHMemoryCache *memoryCache;

@end

@implementation CCHCache

- (instancetype)initWithInMemorySize:(NSUInteger)memoryCacheSizeInBytes
                         andDiskSize:(NSUInteger)diskCacheSizeInBytes
                             forName:(NSString *)name
{
    self = [super init];
    if (self == nil) return nil;

    _name = name;
    _memoryCacheSizeInBytes = memoryCacheSizeInBytes;
    _diskCacheSizeInBytes = diskCacheSizeInBytes;

    _memoryCache = [[CCHMemoryCache alloc] initWithSize:_memoryCacheSizeInBytes
                                               withName:name];

    return self;
}

- (void)objectForKey:(NSString *)key
      withCompletion:(__unused CCHCacheCompletionBlock)completion
{

    void (^memoryCacheCompletion)(NSString *, id<NSCopying>) = ^(__unused NSString *k, __unused  id<NSCopying> v) {

    };

    [self.memoryCache objectForKey:key
                    withCompletion:memoryCacheCompletion];
}

- (void)setObject:(id <NSCopying>)object
           forKey:(NSString *)key
   withCompletion:(__unused CCHCacheCompletionBlock)completion
{
    void (^memoryCacheCompletion)(NSString *, id<NSCopying>) = ^(__unused NSString *k, __unused id<NSCopying> v) {

    };

    [self.memoryCache setObject:object
                         forKey:key
                 withCompletion:memoryCacheCompletion];
}


- (void)removeObjectForKey:(__unused NSString *)key
            withCompletion:(__unused CCHCacheCompletionBlock)completion
{

}

@end
