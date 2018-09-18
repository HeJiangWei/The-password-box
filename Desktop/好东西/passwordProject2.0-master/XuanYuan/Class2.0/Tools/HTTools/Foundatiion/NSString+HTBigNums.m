//
//  NSString+HTBigNums.m
//  pangu
//
//  Created by niesiyang-worker on 2017/12/5.
//  Copyright © 2017年 zby. All rights reserved.
//

#import "NSString+HTBigNums.h"

@implementation NSString (HTBigNums)

- (NSString *(^)(NSString *))add
{
    return ^(NSString *number) {
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:self];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:number];
        NSDecimalNumber *result = [first decimalNumberByAdding:second];
        return result.stringValue;
    };
}

- (NSString *(^)(NSString *))sub
{
    return ^(NSString *number) {
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:self];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:number];
        NSDecimalNumber *result = [first decimalNumberBySubtracting:second];
        return result.stringValue;
    };
}

- (NSString *(^)(NSString *))multiply
{
    return ^(NSString *number) {
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:self];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:number];
        NSDecimalNumber *result = [first decimalNumberByMultiplyingBy:second];
        return result.stringValue;
    };
}

- (NSString *(^)(NSString *))divid
{
    return ^(NSString *number) {
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:self];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:number];
        NSDecimalNumber *result = [first decimalNumberByDividingBy:second];
        return result.stringValue;
    };
}
- (NSString *(^)(NSString *))raisingToPower
{
    return ^(NSString *number) {
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:self];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:number];
        NSDecimalNumber *result = [first decimalNumberByRaisingToPower:second.unsignedIntegerValue];
        return result.stringValue;
    };
}

- (NSString *(^)(NSString *))multiplyingByPowerOf10
{
    return ^(NSString *number) {
        NSDecimalNumber *first = [NSDecimalNumber decimalNumberWithString:self];
        NSDecimalNumber *second = [NSDecimalNumber decimalNumberWithString:number];
        NSDecimalNumber *result = [first decimalNumberByMultiplyingByPowerOf10:second.shortValue];
        return result.stringValue;
    };
}



@end

