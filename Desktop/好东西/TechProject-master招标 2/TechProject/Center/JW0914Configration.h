//
//  JW0914Configration.h
//  hatsune
//
//  Created by Mike on 10/11/JW0914.
//  Copyright © JW0914 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JW0914Configration : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSString *JW0914AVOSBmobAppID;
@property (nonatomic, strong) NSString *JW0914AVOSBmobAppKey;
@property (nonatomic, strong) NSString *JW0914AVOSCloudClassName;
@property (nonatomic, strong) NSString *JW0914AVOSCloudObjectID;
@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) NSString *JW0914shareDesc;
@property (nonatomic, strong) NSString *JW0914versionUrl;
@property (nonatomic, strong) NSString *JW0914jpushAppKey;

@end
