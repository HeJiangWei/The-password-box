//
//  JW0905Configration.m
//  hatsune
//
//  Created by Mike on 10/11/JW0905.
//  Copyright © JW0905 Facebook. All rights reserved.
//

#import "JW0905Configration.h"

@interface JW0905Configration ()

@property (nonatomic, strong) NSUserDefaults *userDefaults;

@end

@implementation JW0905Configration

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static JW0905Configration *config;
    dispatch_once(&onceToken, ^{
        config = [[JW0905Configration alloc] init];
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

#pragma mark - JW0905shareDesc
- (NSString *)JW0905shareDesc {
    return [self.userDefaults stringForKey:@"JW0905shareDesc"];
}

- (void)setJW0905shareDesc:(NSString *)JW0905shareDesc {
    [self.userDefaults setObject:JW0905shareDesc forKey:@"JW0905shareDesc"];
}

#pragma mark - JW0905versionUrl
- (NSString *)JW0905versionUrl {
    return [self.userDefaults stringForKey:@"JW0905versionUrl"];
}

- (void)setJW0905versionUrl:(NSString *)JW0905versionUrl {
    [self.userDefaults setObject:JW0905versionUrl forKey:@"JW0905versionUrl"];
}


#pragma mark - JW0905jpushAppKey

- (NSString *)JW0905jpushAppKey {
    return [self.userDefaults stringForKey:@"JW0905jpushAppKey"];
}

- (void)setJW0905jpushAppKey:(NSString *)JW0905jpushAppKey {
    [self.userDefaults setObject:JW0905jpushAppKey forKey:@"JW0905jpushAppKey"];
}


#pragma mark - Description

- (NSString *)description
{
    return [NSString stringWithFormat:@"\
            JW0905AVOSBmobAppID=%@,\n\
            JW0905AVOSBmobAppKey=%@,\n\
            JW0905AVOSCloudClassName=%@,\n\
            JW0905AVOSCloudObjectID=%@,\n\
            webUrl=%@,\n\
            shareUrl=%@,\n\
            JW0905shareDesc=%@,\n\
            JW0905versionUrl=%@,\n\
            JW0905jpushAppKey=%@",
            self.JW0905AVOSBmobAppID,
            self.JW0905AVOSBmobAppKey,
            self.JW0905AVOSCloudClassName,
            self.JW0905AVOSCloudObjectID,
            self.webUrl,
            self.shareUrl,
            self.JW0905shareDesc,
            self.JW0905versionUrl,
            self.JW0905jpushAppKey];
    
}

@end
