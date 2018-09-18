//
//  Defaults.m
//  DocumentWatermarking 909090909
//
//  Created by apple on 2017/12/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Defaults.h"

@implementation Defaults

/**
 储存模型到userDefault
 
 @param key 需要的key
 @param model 模型
 */
+ (void)saveVauleWithKey:(NSString *)key model:(id)model value:(id)value{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (model) {
        NSDictionary *data = [model mj_keyValues];
        [userDefault setObject:data forKey:key];
    }else {
        [userDefault setObject:value forKey:key];
    }

    [userDefault synchronize];
    
}

+ (id)readValueForKey:(NSString *)key model:(id)model{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (model) {
        return [[model class] mj_objectWithKeyValues:[userDefault objectForKey:key]];
    }
    return [userDefault objectForKey:key];
    
}

+ (void)clearVauleWithKey:(NSString *)key {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:nil forKey:key];
    [userDefault synchronize];
}

+ (void)deleteVauleWithKey:(NSString *)key {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:key];
    [userDefault synchronize];
}


@end
