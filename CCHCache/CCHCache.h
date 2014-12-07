//
//  CCHCache.h
//  CCHCache
//
//  Created by Markus Kauppila on 05/12/14.
//
//

#import <Foundation/Foundation.h>

typedef void (^CCHCacheCompletionBlock)(NSString *key, id <NSCopying> value);

@interface CCHCache : NSObject

/// Name of the cache. Also used as cache directory name.
@property (nonatomic, copy, readonly) NSString *name;

- (instancetype)initWithInMemorySize:(NSUInteger)sizeInBytes
                         andDiskSize:(NSUInteger)sizeInBytes
                             forName:(NSString *)name NS_DESIGNATED_INITIALIZER;

/// Retrieve object for `key`
- (void)objectForKey:(NSString *)key
               withCompletion:(CCHCacheCompletionBlock)completion;

/// Store `object` for a `key`
- (void)setObject:(id <NSCopying>)object
           forKey:(NSString *)key
   withCompletion:(CCHCacheCompletionBlock)completion;

/// Remove object for `key`
- (void)removeObjectForKey:(NSString *)key
            withCompletion:(CCHCacheCompletionBlock)completion;

@end
