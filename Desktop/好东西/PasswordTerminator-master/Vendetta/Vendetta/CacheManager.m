//
//  CacheManager.m
//  Vendetta
//
//  Created byjw chen JW on 15/8/20.
//  Copyright (c) 2018年 chen Yuheng. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager

+ (CacheManager *)sharedInstance
{
    static dispatch_once_t once;
    static CacheManager *cacheManager;
    dispatch_once(&once, ^{
        cacheManager=[[CacheManager alloc] init];
    });
    return cacheManager;
}

-(id)init {
    if (self = [super init]) {
        [self initRootCachePath];
    }
    return self;
}

- (void)initRootCachePath
{
    self.rootCachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

- (BOOL)storeFileToCachepath:(NSString *)cacheFilePath andFileContent:(NSData *)content
{
    NSError *error;
    BOOL result=[content writeToFile:cacheFilePath options:NSDataWritingAtomic error:&error];
    if(error){
        return NO;
    }
    
    if (result){
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)writeFileToCacheWithFilename:(NSString *)filename andFileContent:(NSData *)content
{
    NSFileManager *fileManager=[NSFileManager  defaultManager];
    NSString  *cacheFilePath=[self  getCacheFilePath:filename];
    if (![fileManager fileExistsAtPath:cacheFilePath]) {
        BOOL createSuccess=[fileManager createFileAtPath:cacheFilePath contents:content attributes:nil];
        if (createSuccess) {
        }
    }else{
        [self storeFileToCachepath:cacheFilePath andFileContent:content];
    }
}

- (NSData *)getCacheWithFilepath:(NSString *)path
{
    return [self readCacheFilename:path];
    
}

- (NSData *)readCacheFilename:(NSString *)filename
{
    NSString *cacheFilePath=[self  getCacheFilePath:filename];
    NSData *content = [NSData dataWithContentsOfFile:cacheFilePath];
    return content;
}

- (NSString *)getCacheFilePath:(NSString *)filename
{
    NSString *cacheFilePath=[self.rootCachePath stringByAppendingPathComponent:filename];
    return cacheFilePath;
}

- (void)clearAllCache
{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    for (NSString *file in [fileManager contentsOfDirectoryAtPath:self.rootCachePath error:&error]){
        NSString *filePath = [self.rootCachePath stringByAppendingPathComponent:file];
        BOOL fileDeleted = [fileManager removeItemAtPath:filePath error:&error];
        if (fileDeleted != YES || error != nil){
        }else{
        }
    }
}

- (void)saveWithFilepath:(NSString *)path andContent:(NSData *)content
{
    [self writeFileToCacheWithFilename:path andFileContent:content];
}

- (void)clearWithFilepath:(NSString *)path
{
    NSString *cacheFilePath=[self getCacheFilePath:path];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    [fileManager removeItemAtPath:cacheFilePath error:nil];
}

- (void)savePasswordData:(NSData *)content
{
    [self saveWithFilepath:@"password" andContent:content];
}

- (NSData *)getPasswordData
{
    NSData *data = [self getCacheWithFilepath:@"password"];
    if(data)
    {
        return data;
    }
    else
    {
        PasswordCache *cache = [[PasswordCache alloc]init];
        cache.itemsArray = [NSMutableArray array];
        return [cache data];
    }
}

- (BOOL)removeItemWithTimestamp:(id)timestamp
{
    BOOL flag = NO;
    PasswordCache *cache = [[PasswordCache alloc]initWithData:[self getPasswordData] error:nil];
    NSMutableArray *itemArray = cache.itemsArray;
    
    for(PasswordItem *item in itemArray)
    {
        if(item.timestamp == [timestamp longLongValue])
        {
            [itemArray removeObject:item];
            flag = YES;
        }
    }
    PasswordCache *cacheToCache = [[PasswordCache alloc]init];
    cacheToCache.itemsArray = itemArray;
    
    [self savePasswordData:[cacheToCache data]];
    return flag;
}

@end
