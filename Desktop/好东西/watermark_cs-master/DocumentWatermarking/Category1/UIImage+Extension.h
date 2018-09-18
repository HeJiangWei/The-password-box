//
//  UIImage+Extension.h
//  exercise_图片加水印
//
//  Created by apple on JW 2018/11/9./2.
//  Copyright © 2017年 弄潮者. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterMarkMode.h"
@interface UIImage (Extension)

#pragma mark 加文字水印
//现在的方法
+ (UIImage *)addInImage:(UIImage *)image withModel:(WaterMarkMode*)model IsDoubleImage:(BOOL)isdouble;

#pragma mark 水印图片生成
//现在的方法.这个在水印处理的地方调用
+ (UIImage *)waterMarkImageSize:(CGSize)endImgSize andWaterMarkModel:(WaterMarkMode*)model;
//这个不需要模型,是在预览水印的时候调用
+ (UIImage *)waterMarkImageSize:(CGSize)endImgSize;


//之前的方法
//+ (UIImage *)addText:(NSString *)text inImage:(UIImage *)image fontSize:(CGFloat)fontSize angle:(CGFloat)angle endImgSize:(CGSize)endImgSize textLineSpaceing:(CGFloat)textLineSpaceing red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

//之前的方法
//+ (UIImage *)addText:(NSString *)text fontSize:(CGFloat)fontSize angle:(CGFloat)angle endImgSize:(CGSize)endImgSize textLineSpaceing:(CGFloat)textLineSpaceing red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (UIImage *)clipImageWithRect:(CGRect)rect;
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
- (UIImage *)scaleImageWithSize:(CGSize)size;
@end
