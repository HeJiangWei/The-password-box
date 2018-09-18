//
//  JW0914Configration.m
//  hatsune
//
//  Created by Mike on 10/11/JW0914.
//  Copyright © JW0914 Facebook. All rights reserved.
//

#import "JW0914Configration.h"

@interface JW0914Configration ()

@property (nonatomic, strong) NSUserDefaults *userDefaults;

@end

@implementation JW0914Configration

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static JW0914Configration *config;
    dispatch_once(&onceToken, ^{
        config = [[JW0914Configration alloc] init];
        config.userDefaults = [NSUserDefaults standardUserDefaults];
    });
    return config;
}


#pragma mark - webUrl
- (NSString *)webUrl {
    NSLog(@"%@",[self.userDefaults stringForKey:@"webUrl"]);
    return [self.userDefaults stringForKey:@"webUrl"];
}
- (void)setWebUrl:(NSString *)webUrl {
    [self.userDefaults setObject:webUrl forKey:@"webUrl"];
}

#pragma mark - shareUrl
- (NSString *)shareUrl {
    return [self.userDefaults stringForKey:@"shareUrl"];
}

- (void)setShareUrl:(NSString *)shareUrl {
    [self.userDefaults setObject:shareUrl forKey:@"shareUrl"];
}

#pragma mark - JW0914shareDesc
- (NSString *)JW0914shareDesc {
    return [self.userDefaults stringForKey:@"JW0914shareDesc"];
}

- (void)setJW0914shareDesc:(NSString *)JW0914shareDesc {
    [self.userDefaults setObject:JW0914shareDesc forKey:@"JW0914shareDesc"];
}

#pragma mark - JW0914versionUrl
- (NSString *)JW0914versionUrl {
    return [self.userDefaults stringForKey:@"JW0914versionUrl"];
}

- (void)setJW0914versionUrl:(NSString *)JW0914versionUrl {
    [self.userDefaults setObject:JW0914versionUrl forKey:@"JW0914versionUrl"];
}


#pragma mark - JW0914jpushAppKey

- (NSString *)JW0914jpushAppKey {
    return [self.userDefaults stringForKey:@"JW0914jpushAppKey"];
}

- (void)setJW0914jpushAppKey:(NSString *)JW0914jpushAppKey {
    [self.userDefaults setObject:JW0914jpushAppKey forKey:@"JW0914jpushAppKey"];
}


#pragma mark - Description

- (NSString *)description
{
    return [NSString stringWithFormat:@"\
            JW0914AVOSBmobAppID=%@,\n\
            JW0914AVOSBmobAppKey=%@,\n\
            JW0914AVOSCloudClassName=%@,\n\
            JW0914AVOSCloudObjectID=%@,\n\
            webUrl=%@,\n\
            shareUrl=%@,\n\
            JW0914shareDesc=%@,\n\
            JW0914versionUrl=%@,\n\
            JW0914jpushAppKey=%@",
            self.JW0914AVOSBmobAppID,
            self.JW0914AVOSBmobAppKey,
            self.JW0914AVOSCloudClassName,
            self.JW0914AVOSCloudObjectID,
            self.webUrl,
            self.shareUrl,
            self.JW0914shareDesc,
            self.JW0914versionUrl,
            self.JW0914jpushAppKey];
    
}

@end
