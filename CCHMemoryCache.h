//
//  CCHMemoryCache.h
//  CCHCache
//
//  Created by Markus Kauppila on 07/12/14.
//
//

#import <Foundation/Foundation.h>

#import "CCHCache.h"

@interface CCHMemoryCache : NSObject

- (instancetype)initWithSize:(NSUInteger)sizeInBytes
                    withName:(NSString *)name;

#pragma mark - Public API

- (id<NSCopying>)objectForKey:(NSString *)key
               withCompletion:(CCHCacheCompletionBlock)completion;

- (void)setObject:(id <NSCopying>)object
           forKey:(NSString *)key
   withCompletion:(CCHCacheCompletionBlock)completion;

- (void)removeObjectForKey:(NSString *)key
            withCompletion:(CCHCacheCompletionBlock)completion;

@end
