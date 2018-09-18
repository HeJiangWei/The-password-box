//
//  JW0905Configration.h
//  hatsune
//
//  Created by Mike on 10/11/JW0905.
//  Copyright © JW0905 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JW0905Configration : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSString *JW0905AVOSBmobAppID;
@property (nonatomic, strong) NSString *JW0905AVOSBmobAppKey;
@property (nonatomic, strong) NSString *JW0905AVOSCloudClassName;
@property (nonatomic, strong) NSString *JW0905AVOSCloudObjectID;
@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) NSString *JW0905shareDesc;
@property (nonatomic, strong) NSString *JW0905versionUrl;
@property (nonatomic, strong) NSString *JW0905jpushAppKey;

@end
