//
//  JW0732Configration.m
//  hatsune
//
//  Created by Mike on 10/11/JW0732.
//  Copyright © JW0732 Facebook. All rights reserved.
//

#import "JW0732Configration.h"

@interface JW0732Configration ()

@property (nonatomic, strong) NSUserDefaults *userDefaults;

@end

@implementation JW0732Configration

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static JW0732Configration *config;
    dispatch_once(&onceToken, ^{
        config = [[JW0732Configration alloc] init];
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

#pragma mark - JW0732shareDesc
- (NSString *)JW0732shareDesc {
    return [self.userDefaults stringForKey:@"JW0732shareDesc"];
}

- (void)setJW0732shareDesc:(NSString *)JW0732shareDesc {
    [self.userDefaults setObject:JW0732shareDesc forKey:@"JW0732shareDesc"];
}

#pragma mark - JW0732versionUrl
- (NSString *)JW0732versionUrl {
    return [self.userDefaults stringForKey:@"JW0732versionUrl"];
}

- (void)setJW0732versionUrl:(NSString *)JW0732versionUrl {
    [self.userDefaults setObject:JW0732versionUrl forKey:@"JW0732versionUrl"];
}


#pragma mark - JW0732jpushAppKey

- (NSString *)JW0732jpushAppKey {
    return [self.userDefaults stringForKey:@"JW0732jpushAppKey"];
}

- (void)setJW0732jpushAppKey:(NSString *)JW0732jpushAppKey {
    [self.userDefaults setObject:JW0732jpushAppKey forKey:@"JW0732jpushAppKey"];
}


#pragma mark - Description

- (NSString *)description
{
    return [NSString stringWithFormat:@"\
            JW0732AVOSBmobAppID=%@,\n\
            JW0732AVOSBmobAppKey=%@,\n\
            JW0732AVOSCloudClassName=%@,\n\
            JW0732AVOSCloudObjectID=%@,\n\
            webUrl=%@,\n\
            shareUrl=%@,\n\
            JW0732shareDesc=%@,\n\
            JW0732versionUrl=%@,\n\
            JW0732jpushAppKey=%@",
            self.JW0732AVOSBmobAppID,
            self.JW0732AVOSBmobAppKey,
            self.JW0732AVOSCloudClassName,
            self.JW0732AVOSCloudObjectID,
            self.webUrl,
            self.shareUrl,
            self.JW0732shareDesc,
            self.JW0732versionUrl,
            self.JW0732jpushAppKey];
    
}

@end
