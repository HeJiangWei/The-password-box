//
//  WaterMarkMode.h
//  DocumentWatermarking 909090909
//
//  Created by apple on 2017/12/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaterMarkMode : NSObject<NSCoding>

@property (nonatomic , copy) NSString * content;//水印内容
@property (nonatomic , assign) CGFloat fontSize;//水印文字的大小
@property (nonatomic , copy) NSString* fontString;//水印文字说摩纳哥,大号,小号===

@property (nonatomic , assign) NSInteger roration;//水印文字的旋转角度
@property (nonatomic , assign) CGFloat alpha;//水印文字的透明度
@property (nonatomic , copy) NSString * fontColor;//水印文字的颜色
@property (nonatomic,assign) CGFloat red;//水印文字的red
@property (nonatomic,assign) CGFloat green;//水印文字的green
@property (nonatomic,assign) CGFloat blue;//水印文字的blue
@property (nonatomic,strong) NSMutableArray * waterMarkContentArr;//水印内容数组

@property(nonatomic,assign)NSInteger showCount;//0-无限  1-一条 2-二条 3-三条
@property(nonatomic,copy)NSString *showCountString;//无限  一次 2次 3次

@property(nonatomic,strong)NSValue *waterMarkPoint;//水印的相对位置
@property(nonatomic,strong)NSValue *doublePhotoWaterMarkPoint;//水印的相对位置

@property(nonatomic,assign)BOOL isSetWaterMark;//是否设置过水印


//创建一个默认的模型
+(WaterMarkMode*)getDefaultModelWithEndImageSize:(CGSize)endImgSize;

@end
