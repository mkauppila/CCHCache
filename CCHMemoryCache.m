//
//  CCHMemoryCache.m
//  CCHCache
//
//  Created by Markus Kauppila on 07/12/14.
//
//

#import "CCHMemoryCache.h"

@interface CCHMemoryCache ()

@property (nonatomic, readonly) NSUInteger sizeInBytes;
@property (nonatomic, copy, readonly) NSString *name;

@end

@implementation CCHMemoryCache

- (instancetype)initWithSize:(NSUInteger)sizeInBytes
                    withName:(NSString *)name;
{
    self = [super init];
    if (self == nil) return nil;


    _sizeInBytes = sizeInBytes;
    _name = name;

    return self;
}

- (id<NSCopying>)objectForKey:(NSString *)key
               withCompletion:(CCHCacheCompletionBlock)completion
{

}

- (void)setObject:(id <NSCopying>)object
           forKey:(NSString *)key
   withCompletion:(CCHCacheCompletionBlock)completion
{

}

- (void)removeObjectForKey:(NSString *)key
            withCompletion:(CCHCacheCompletionBlock)completion
{

}

@end
