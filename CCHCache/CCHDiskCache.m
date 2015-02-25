//
// Created by Markus Kauppila on 25/02/15.
//

#import "CCHDiskCache.h"

@interface CCHDiskCache ()

@property (nonatomic, readonly) NSUInteger sizeInBytes;
@property (nonatomic, copy, readonly) NSString *name;

@end

@implementation CCHDiskCache

- (instancetype)initWithSize:(NSUInteger)sizeInBytes
                    withName:(NSString *)name
{
    self = [super init];
    if (self == nil) return nil;


    _sizeInBytes = sizeInBytes;
    _name = name;

    return self;
}

- (void)objectForKey:(__unused NSString *)key
      withCompletion:(__unused CCHCacheCompletionBlock)completion
{

}

- (void)setObject:(__unused id <NSCopying>)object
           forKey:(__unused NSString *)key
   withCompletion:(__unused CCHCacheCompletionBlock)completion
{

}

- (void)removeObjectForKey:(__unused NSString *)key
            withCompletion:(__unused CCHCacheCompletionBlock)completion
{

}

@end
