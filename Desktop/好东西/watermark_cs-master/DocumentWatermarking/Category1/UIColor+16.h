//
//  UIColor+16.h
//  prfcloud
//
//  Created by wucai on 13-8-21.
//  Copyright (c) 2013年 Visen Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(Hex)

//16进制颜色(html颜色值)字符串转为UIColor
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

@end
