//
//  WaterMarkMode.m
//  DocumentWatermarking 909090909
//
//  Created by apple on 2017/12/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WaterMarkMode.h"

@implementation WaterMarkMode

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.content forKey:@"content"];
    [encoder encodeFloat:self.fontSize forKey:@"fontSize"];
    [encoder encodeObject:self.fontString forKey:@"fontString"];
    [encoder encodeInteger:self.roration forKey:@"roration"];
    [encoder encodeFloat:self.alpha forKey:@"alpha"];
    [encoder encodeFloat:self.red forKey:@"red"];
    [encoder encodeFloat:self.green forKey:@"green"];
    [encoder encodeFloat:self.blue forKey:@"blue"];
    [encoder encodeObject:self.fontColor forKey:@"fontColor"];
    [encoder encodeObject:self.waterMarkContentArr forKey:@"waterContentArr"];
    [encoder encodeObject:self.waterMarkPoint forKey:@"waterMarkPoint"];
    [encoder encodeObject:self.doublePhotoWaterMarkPoint forKey:@"doublePhotoWaterMarkPoint"];
    [encoder encodeBool:self.isSetWaterMark forKey:@"isSetWaterMark"];
    [encoder encodeInteger:self.showCount forKey:@"showCount"];
    [encoder encodeObject:self.showCountString forKey:@"showCountString"];

}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.content = [decoder decodeObjectForKey:@"content"];
        self.fontSize = [decoder decodeFloatForKey:@"fontSize"];
        self.fontString = [decoder decodeObjectForKey:@"fontString"];
        self.roration = [decoder decodeIntegerForKey:@"roration"];
        self.alpha = [decoder decodeFloatForKey:@"alpha"];
        self.red = [decoder decodeFloatForKey:@"red"];
        self.green = [decoder decodeFloatForKey:@"green"];
        self.blue = [decoder decodeFloatForKey:@"blue"];
        self.fontColor = [decoder decodeObjectForKey:@"fontColor"];
        self.waterMarkContentArr = [decoder decodeObjectForKey:@"waterContentArr"];
        self.waterMarkPoint = [decoder decodeObjectForKey:@"waterMarkPoint"];
        self.doublePhotoWaterMarkPoint = [decoder decodeObjectForKey:@"doublePhotoWaterMarkPoint"];
        self.isSetWaterMark = [decoder decodeBoolForKey:@"isSetWaterMark"];
        self.showCount = [decoder decodeIntegerForKey:@"showCount"];
        self.showCountString = [decoder decodeObjectForKey:@"showCountString"];
    }
    return self;
}

//创建一个默认的模型
+(WaterMarkMode*)getDefaultModelWithEndImageSize:(CGSize)endImgSize{
    WaterMarkMode*  model = [[WaterMarkMode alloc]init];
    model.content = @"请输入水印内容";
    model.fontSize = 32;
    model.fontString = @"大";
    model.fontColor = @"黑色";
    model.roration = -45;
    model.alpha = 0.2;
    model.red = 0;
    model.blue = 0;
    model.green = 0;
    model.waterMarkPoint = [NSValue valueWithCGPoint:CGPointMake(-endImgSize.width/2.0, -endImgSize.height/2.0)];
    model.doublePhotoWaterMarkPoint = [NSValue valueWithCGPoint:CGPointMake(-endImgSize.width/2.0, -endImgSize.height/2.0)];
    model.waterMarkContentArr = [NSMutableArray arrayWithObjects:@"请输入水印内容",@"仅用于入职身份认证",@"仅用于中国银行开户认证",@"仅用于电信宽带业务办理", nil];
    model.isSetWaterMark = NO;
    model.showCount = 0;//显示无限条数
    model.showCountString = @"不限";
    return model;
}

@end
