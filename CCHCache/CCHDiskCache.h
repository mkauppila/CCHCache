//
// Created by Markus Kauppila on 25/02/15.
//

#import <Foundation/Foundation.h>

#import "CCHCache.h"

@interface CCHDiskCache : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSize:(NSUInteger)sizeInBytes
                    withName:(NSString *)name;

- (void)objectForKey:(NSString *)key
      withCompletion:(CCHCacheCompletionBlock)completion;

- (void)setObject:(id <NSCopying>)object
           forKey:(NSString *)key
   withCompletion:(CCHCacheCompletionBlock)completion;

- (void)removeObjectForKey:(NSString *)key
            withCompletion:(CCHCacheCompletionBlock)completion;

@end
