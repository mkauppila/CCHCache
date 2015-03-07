//
// Created by Markus Kauppila on 25/02/15.
//

#import "CCHDiskCache.h"

@interface CCHDiskCache ()

@property (nonatomic, strong) NSFileManager *fileManager;

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

    _fileManager = [[NSFileManager alloc] init];
    [self createCacheDirectory];

    return self;
}

- (void)createCacheDirectory
{
    NSError *error;
    BOOL didCreateDirectory = [self.fileManager createDirectoryAtPath:[self diskCacheDirectoryPath]
                                          withIntermediateDirectories:NO
                                                           attributes:nil
                                                                error:&error];
    if (!didCreateDirectory && error && [error code] != 516) {
        NSLog(@"Failed to create directory for disk cache '%@'", self.name);
        NSLog(@"    error: %@", error);
        NSLog(@"Might have already created");
    } else {
        NSLog(@"Created directory for cache: %@", self.name);
    }
}

- (NSString *)diskCacheDirectoryPath
{
    static NSString *diskCacheDirectory;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSString *cacheDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        diskCacheDirectory = [cacheDirectoryPath stringByAppendingPathComponent:self.name];
    });
    return diskCacheDirectory;
}

#pragma mark - External interface

- (void)objectForKey:(__unused NSString *)key
      withCompletion:(__unused CCHCacheCompletionBlock)completion
{
    NSString *filename = [[self diskCacheDirectoryPath] stringByAppendingPathComponent:key];
    id value = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
    completion(key, value);
}

- (void)setObject:(__unused id <NSCopying>)value
           forKey:(__unused NSString *)key
   withCompletion:(__unused CCHCacheCompletionBlock)completion
{
    NSString *filename = [[self diskCacheDirectoryPath] stringByAppendingPathComponent:key];
    BOOL didWrite = [NSKeyedArchiver archiveRootObject:value toFile:filename];
    if (didWrite) {
        NSError *error;
        NSDictionary *attributes = [self.fileManager attributesOfItemAtPath:filename error:&error];
        if (!attributes && error) {
            NSLog(@"Failed to read file attributes for %@", filename);
            NSLog(@"    error: %@", error);
        }

        NSLog(@"date: %@", attributes[NSFileModificationDate]);
        NSLog(@"size: %@", attributes[NSFileSize]);

        NSLog(@"did store value %@", value);
        completion(key, value);
    }
}

- (void)removeObjectForKey:(__unused NSString *)key
            withCompletion:(__unused CCHCacheCompletionBlock)completion
{
    NSString *filename = [[self diskCacheDirectoryPath] stringByAppendingPathComponent:key];
    NSError *error;
    BOOL didRemove = [self.fileManager removeItemAtPath:filename error:&error];
    if (!didRemove && error) {
        NSLog(@"Failed to remove file at %@", filename);
        NSLog(@"    error: %@", error);
    } else {
        completion(key, nil);
    }
}

@end
