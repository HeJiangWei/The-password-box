//
//  Defaults.h
//  DocumentWatermarking 909090909
//
//  Created by apple on 2017/12/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Defaults : NSObject

+ (void)saveVauleWithKey:(NSString *)key model:(id)model value:(id)value;

+ (id)readValueForKey:(NSString *)key model:(id)model;

+ (void)clearVauleWithKey:(NSString *)key;

+ (void)deleteVauleWithKey:(NSString *)key;

@end
