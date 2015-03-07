//
// Created by Markus Kauppila on 25/02/15.
//

#import "CCHDiskCache.h"

@interface CCHDiskCache ()

@property (nonatomic, strong) NSFileManager *fileManager;

@property (nonatomic, readonly) NSUInteger sizeInBytes;
@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy) NSMutableDictionary *fileSizesInBytes;
@property (nonatomic, copy) NSMutableDictionary *fileModificationDates;

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
    [self initializeCacheContents];

    return self;
}

- (void)initializeCacheContents
{
    BOOL (^errorHandler)(NSURL *, NSError *) = ^BOOL(NSURL *url, NSError *error) {
        NSLog(@"Error white enumerationg url: %@. Continuing enumeration", url);
        NSLog(@"    error: %@", error);
        return YES;
    };

    NSMutableDictionary *mutableModificationDates = [NSMutableDictionary new];
    NSMutableDictionary *mutableFileSizes = [NSMutableDictionary new];

    NSDirectoryEnumerator *directoryEnumerator =
            [self.fileManager enumeratorAtURL:[NSURL URLWithString:[self diskCacheDirectoryPath]]
                   includingPropertiesForKeys:@[NSURLAttributeModificationDateKey]
                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                 errorHandler:errorHandler];
    for (NSURL *fileURL in directoryEnumerator) {
        NSError *error;
        NSDictionary *attributes = [self.fileManager attributesOfItemAtPath:[fileURL path] error:&error];
        if (!attributes && error) {
            NSLog(@"Error reading attributes from file path: %@", fileURL);
            NSLog(@"    error: %@", error);
        } else {
            NSNumber *const fileSizeInBytes = attributes[NSFileSize];
            NSDate *const modificationDate = attributes[NSFileModificationDate];
            NSString *const filename = [fileURL lastPathComponent];

            NSLog(@"%@: => %@ bytes, %@", filename, fileSizeInBytes, modificationDate);

            mutableFileSizes[filename] = fileSizeInBytes;
            mutableModificationDates[filename] = modificationDate;
        }
    }
}

- (void)createCacheDirectory
{
    NSError *error;
    BOOL didCreateDirectory = [self.fileManager createDirectoryAtPath:[self diskCacheDirectoryPath]
                                          withIntermediateDirectories:NO
                                                           attributes:nil
                                                                error:&error];
    if (!didCreateDirectory && error) {
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

- (void)objectForKey:(NSString *)key
      withCompletion:(CCHCacheCompletionBlock)completion
{
    NSDate *const newModificationDate = [NSDate date];
    NSString *const filePath = [[self diskCacheDirectoryPath] stringByAppendingPathComponent:key];

    NSDictionary *newAttributes = @{
        NSFileModificationDate: newModificationDate,
    };

    NSError *error;
    BOOL didUpdate = [self.fileManager setAttributes:newAttributes
                                        ofItemAtPath:filePath
                                               error:&error];
    if (!didUpdate && error) {
        NSLog(@"Failed to update file attributes at pat: %@", filePath);
        NSLog(@"    error: %@", error);
    }

    NSString *filename = [[self diskCacheDirectoryPath] stringByAppendingPathComponent:key];
    id value = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
    completion(key, value);
}

- (void)setObject:(id <NSCopying>)value
           forKey:(NSString *)key
   withCompletion:(CCHCacheCompletionBlock)completion
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

        self.fileSizesInBytes[filename] = attributes[NSFileSize];
        self.fileModificationDates[filename] = attributes[NSFileModificationDate];

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
