//
// Created by Markus Kauppila on 25/02/15.
//

#import <Foundation/Foundation.h>

#import "CCHCache.h"

@interface CCHDiskCache : NSObject

- (instancetype)initWithSize:(NSUInteger)sizeInBytes
                    withName:(NSString *)name;

#pragma mark - Public API

- (void)objectForKey:(NSString *)key
      withCompletion:(CCHCacheCompletionBlock)completion;

- (void)setObject:(id <NSCopying>)object
           forKey:(NSString *)key
   withCompletion:(CCHCacheCompletionBlock)completion;

- (void)removeObjectForKey:(NSString *)key
            withCompletion:(CCHCacheCompletionBlock)completion;

@end
