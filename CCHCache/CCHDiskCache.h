//
// Created by Markus Kauppila on 25/02/15.
//

#import <Foundation/Foundation.h>

#import "CCHCache.h"

typedef void (^CCHCacheCompletionBlock)(NSString *key, id <NSCopying> value);

@interface CCHDiskCache : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSize:(NSUInteger)sizeInBytes
                    withName:(NSString *)name NS_DESIGNATED_INITIALIZER;

- (void)objectForKey:(NSString *)key
      withCompletion:(CCHCacheCompletionBlock)completion;

- (void)setObject:(id <NSCopying>)value
           forKey:(NSString *)key
   withCompletion:(CCHCacheCompletionBlock)completion;

- (void)removeObjectForKey:(NSString *)key
            withCompletion:(CCHCacheCompletionBlock)completion;

@end
