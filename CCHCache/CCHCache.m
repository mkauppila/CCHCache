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

    return self;
}

- (void)objectForKey:(__unused NSString *)key
               withCompletion:(__unused CCHCacheCompletionBlock)completion
{
    return nil;
}

- (void)setObject:(__unused id <NSCopying>)object
           forKey:(__unused NSString *)key
   withCompletion:(__unused CCHCacheCompletionBlock)completion
{
}

@end
