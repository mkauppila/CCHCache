//
//  CCHMemoryCache.h
//  CCHCache
//
//  Created by Markus Kauppila on 07/12/14.
//
//

#import <Foundation/Foundation.h>

#import "CCHCache.h"

#import "CCHCache.h"

typedef void (^CCHCacheCompletionBlock)(NSString *key, id <NSCopying> value);

@interface CCHMemoryCache : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSize:(NSUInteger)sizeInBytes
                    withName:(NSString *)name NS_DESIGNATED_INITIALIZER;

#pragma mark - Public API

- (void)objectForKey:(NSString *)key
               withCompletion:(CCHCacheCompletionBlock)completion;

- (void)setObject:(id <NSCopying>)object
           forKey:(NSString *)key
   withCompletion:(CCHCacheCompletionBlock)completion;

- (void)removeObjectForKey:(NSString *)key
            withCompletion:(CCHCacheCompletionBlock)completion;

@end
