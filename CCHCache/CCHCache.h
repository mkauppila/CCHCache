//
//  CCHCache.h
//  CCHCache
//
//  Created by Markus Kauppila on 05/12/14.
//
//

#import <Foundation/Foundation.h>

#import "CCHMemoryCache.h"
#import "CCHDiskCache.h"

typedef void (^CCHCacheCompletionBlock)(NSString *key, id <NSCopying> value);

@interface CCHCache : NSObject

/// Name of the cache. Also used as cache directory name.
@property (nonatomic, copy, readonly) NSString *name;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithInMemorySize:(NSUInteger)inMemorySizeInBytes
                         andDiskSize:(NSUInteger)diskSizeInBytes
                             forName:(NSString *)name NS_DESIGNATED_INITIALIZER;

- (void)objectForKey:(NSString *)key
               withCompletion:(CCHCacheCompletionBlock)completion;

- (void)setObject:(id <NSCopying>)object
           forKey:(NSString *)key
   withCompletion:(CCHCacheCompletionBlock)completion;

- (void)removeObjectForKey:(NSString *)key
            withCompletion:(CCHCacheCompletionBlock)completion;

@end
