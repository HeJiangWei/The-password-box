//
//  NSString+HTBigNums.h
//  pangu
//
//  Created by niesiyang-worker on 2017/12/5.
//  Copyright © 2017年 zby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HTBigNums)

- (NSString * (^)(NSString *number))add;        //加
- (NSString * (^)(NSString *number))sub;        //减
- (NSString * (^)(NSString *number))multiply;   //乘
- (NSString * (^)(NSString *number))divid;      //除


/**
 传参是无符号整型的字符串
 */
- (NSString * (^)(NSString *number))raisingToPower;              //number次方


/**
 传参是short字符串
 */
- (NSString * (^)(NSString *number))multiplyingByPowerOf10;      //乘以 10的number次方

@end
