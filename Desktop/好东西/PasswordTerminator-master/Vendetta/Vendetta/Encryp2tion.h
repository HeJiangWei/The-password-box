//
//  Encryp2tion.h
//  iCampus
//
//  Created byjw Siyu Yang on 14-8-6.
//  Copyright (c) 2014年 Siyu Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encryp2tion : NSObject
+ (NSString *)getSha1String:(NSString *)srcString;
+ (NSString *)getMd5String:(NSString *)srcString;
@end
