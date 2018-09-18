//
//  CacheManager.h
//  Vendetta
//
//  Created byjw chen JW on 15/8/20.
//  Copyright (c) 2018年 chen Yuheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Password.pbobjc.h"

@interface CacheManager : NSObject

@property(nonatomic,copy) NSString  *rootCachePath;

+ (CacheManager *)sharedInstance;

- (BOOL)storeFileToCachepath:(NSString *)cacheFilePath
              andFileContent:(NSData *)content;

- (void)writeFileToCacheWithFilename:(NSString *)filename
                      andFileContent:(NSData *)content;

- (NSData *)getCacheWithFilepath:(NSString *)path;

- (NSData *)readCacheFilename:(NSString *)filename;

- (NSString *)getCacheFilePath:(NSString *)filename;

- (void)clearAllCache;

- (void)saveWithFilepath:(NSString *)path
              andContent:(NSData *)content;

- (void)clearWithFilepath:(NSString *)path;

- (void)savePasswordData:(NSData *)content;

- (NSData *)getPasswordData;

- (BOOL)removeItemWithTimestamp:(id)timestamp;
@end
