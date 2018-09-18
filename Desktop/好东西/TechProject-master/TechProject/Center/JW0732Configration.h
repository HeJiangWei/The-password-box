//
//  JW0732Configration.h
//  hatsune
//
//  Created by Mike on 10/11/JW0732.
//  Copyright © JW0732 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JW0732Configration : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSString *JW0732AVOSBmobAppID;
@property (nonatomic, strong) NSString *JW0732AVOSBmobAppKey;
@property (nonatomic, strong) NSString *JW0732AVOSCloudClassName;
@property (nonatomic, strong) NSString *JW0732AVOSCloudObjectID;
@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) NSString *JW0732shareDesc;
@property (nonatomic, strong) NSString *JW0732versionUrl;
@property (nonatomic, strong) NSString *JW0732jpushAppKey;

@end
