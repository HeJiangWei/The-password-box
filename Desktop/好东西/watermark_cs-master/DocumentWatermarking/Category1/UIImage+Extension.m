//
//  UIImage+Extension.m
//  exercise_图片加水印
//
//  Created by apple on JW 2018/11/9./2.
//  Copyright © 2017年 弄潮者. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)addInImage:(UIImage *)image withModel:(WaterMarkMode*)model IsDoubleImage:(BOOL)isdouble
{
    
    //如果图片不需要那么大的话,可以缩小画布的大小
    //    endImgSize.width = endImgSize.width/[UIScreen mainScreen].scale;
    //    endImgSize.height = endImgSize.height/[UIScreen mainScreen].scale;
    // 开启上下文
    CGSize endImgSize = image.size;
    UIGraphicsBeginImageContext(CGSizeMake(endImgSize.width, endImgSize.height));//这种方式会模糊
    //    UIGraphicsBeginImageContextWithOptions(endImgSize, NO, [UIScreen mainScreen].scale);//高清
    // 绘制底部图片
    [image drawInRect:CGRectMake(0, 0, endImgSize.width, endImgSize.height)];
    // 水印图片
    UIImage *waterMarkImg = [self waterMarkImageSize:CGSizeMake(endImgSize.width*kwaterMarkFrameMultiple, endImgSize.height*kwaterMarkFrameMultiple) andWaterMarkModel:model];
    // 绘制水印
    //    [waterMarkImg drawInRect:CGRectMake(-endImgSize.height, -endImgSize.height, endImgSize.height*5, endImgSize.height*5)];
    CGPoint waterPoint = CGPointZero;
    if (isdouble) {
        waterPoint = model.doublePhotoWaterMarkPoint.CGPointValue;
    }
    else{
        waterPoint = model.waterMarkPoint.CGPointValue;
    }
    [waterMarkImg drawInRect:CGRectMake(waterPoint.x*[UIScreen mainScreen].scale, waterPoint.y*[UIScreen mainScreen].scale,endImgSize.width*kwaterMarkFrameMultiple, endImgSize.height*kwaterMarkFrameMultiple)];//从这张图片的哪里开始画
    // 生成图片
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    // 结束画布
    UIGraphicsEndImageContext();
    // 返回图片
    return newImg;
    
}


#pragma mark 水印图片生成
+ (UIImage *)waterMarkImageSize:(CGSize)endImgSize andWaterMarkModel:(WaterMarkMode*)model{
    if (model == nil) {
        model = [WaterMarkMode getDefaultModelWithEndImageSize:endImgSize];
    }
    
    NSLog(@"画布的大小是不是相同的%@",NSStringFromCGSize(endImgSize));
    // 扩大字体
    CGFloat font = model.fontSize*[UIScreen mainScreen].scale;
    //对角线
    CGFloat sqrtLength = sqrt(endImgSize.width*endImgSize.width + endImgSize.height*endImgSize.height);
    
    // 开启画布
    UIGraphicsBeginImageContext(CGSizeMake(endImgSize.width, endImgSize.height));//这种方式会模糊,文字可以不用那么高清
    //    UIGraphicsBeginImageContextWithOptions(CGSizeMake(endImgSize.width, endImgSize.height), NO, [UIScreen mainScreen].scale);//这种高清的
    //开始旋转上下文矩阵，绘制水印文字
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //将绘制原点（0，0）调整到源image的中心
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(endImgSize.width/2, endImgSize.height/2));
    //以绘制原点为中心旋转
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(model.roration*M_PI*2/360));
    //将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-endImgSize.width/2, -endImgSize.height/2));
    
    // 设置颜色
    [[UIColor clearColor] set];
    //设置文字的颜色以及透明度
    UIColor * textColor = [UIColor colorWithRed:model.red green:model.green blue:model.blue alpha:model.alpha];

    //设置水印字体的行间距
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    
    // 文字size
    CGSize textSize = [model.content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    NSLog(@"难不成文字大小不一样%@",NSStringFromCGSize(textSize));
    //     文字绘制区域长度
    CGFloat textW = textSize.width + font*3;//空3个字符
    
    // 文字绘制区域高度
    CGFloat textH = textSize.height + font*3;//空3行
    
    //    //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
    //    CGFloat orignX = -(sqrtLength-endImgSize.width)/2;
    //    CGFloat orignY = -(sqrtLength-endImgSize.height)/2;
    //
    ////     绘制文字(正常)
    //    for (int i=0; i<ceil(sqrtLength/(textSize.height)); i++) {
    //        for (int j=0; j<ceil(sqrtLength/textSize.width); j++) {
    //            CGFloat contentSpace = font*3;
    //            if (i%2==0) {
    //                contentSpace = 0;
    //            }
    //            [model.content drawInRect:CGRectMake(orignX+textW*j+contentSpace, orignY+textH*i, textSize.width, textSize.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font], NSForegroundColorAttributeName:textColor}];
    //        }
    //    }
    //    switch (model.showCount) {
    //        case 1:
    //        case 2:
    //        case 3:
    //        {
    if (model.showCount!=0) {
        CGFloat showCountzero = model.showCount==1?0:font*3;
        CGFloat showCountHeight = font*3*(model.showCount-1);
        for (int i=0; i<model.showCount; i++) {
            CGFloat contentSpace = font*3;
            if (i%2==0) {
                contentSpace = 0;
            }
            [model.content drawInRect:CGRectMake((endImgSize.width-textSize.width-showCountzero)/2+contentSpace, (endImgSize.height-textSize.height*model.showCount-showCountHeight)/2+textH*i, textSize.width, textSize.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font], NSForegroundColorAttributeName:textColor}];
        }
    }
    else{
        //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
        CGFloat orignX = -(sqrtLength-endImgSize.width)/2;
        CGFloat orignY = -(sqrtLength-endImgSize.height)/2;
        
        // 绘制文字(正常)
        for (int i=0; i<ceil(sqrtLength/(textSize.height)); i++) {
            for (int j=0; j<ceil(sqrtLength/textSize.width); j++) {
                CGFloat contentSpace = 0;
                if (i%2==0) {
                    contentSpace = font*3;
                }
                [model.content drawInRect:CGRectMake(orignX+textW*j+contentSpace, orignY+textH*i, textSize.width, textSize.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font], NSForegroundColorAttributeName:textColor,NSParagraphStyleAttributeName:style}];
            }
        }
        
    }
    
    // 生成水印图片
    UIImage *waterMarkImg = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束画布
    UIGraphicsEndImageContext();
    // 返回图片
    return waterMarkImg;
}

+(UIImage *)waterMarkImageSize:(CGSize)endImgSize{
    
    NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:kWaterMarkModel];
    WaterMarkMode*  model;
    if (modelData==nil) {
        model = [WaterMarkMode getDefaultModelWithEndImageSize:endImgSize];

        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:model];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kWaterMarkModel];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    }
    
    // 扩大字体
    CGFloat font = model.fontSize;
    //对角线
    CGFloat sqrtLength = sqrt(endImgSize.width*endImgSize.width + endImgSize.height*endImgSize.height);
    
    // 开启画布
    UIGraphicsBeginImageContext(CGSizeMake(endImgSize.width, endImgSize.height));//这种方式会模糊
    //    UIGraphicsBeginImageContextWithOptions(CGSizeMake(wh, wh), NO, [UIScreen mainScreen].scale);//这种高清的
    //开始旋转上下文矩阵，绘制水印文字
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //将绘制原点（0，0）调整到源image的中心
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(endImgSize.width/2, endImgSize.height/2));
    //以绘制原点为中心旋转
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(model.roration*M_PI*2/360));
    //将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-endImgSize.width/2, -endImgSize.height/2));
    
    // 设置颜色
    [[UIColor clearColor] set];
    //设置文字的颜色以及透明度
    UIColor * textColor = [UIColor colorWithRed:model.red green:model.green blue:model.blue alpha:model.alpha];
    
    //设置水印字体的行间距
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    
    // 文字size
    CGSize textSize = [model.content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    NSLog(@"文字的大小%@",NSStringFromCGSize(textSize));
    //     文字绘制区域长度
    CGFloat textW = textSize.width + font*3;//空3个字符
    // 文字绘制区域高度
    CGFloat textH = textSize.height + font*3;//空三行
    
    
    if (model.showCount!=0) {
        CGFloat showCountzero = model.showCount==1?0:font*3;
        CGFloat showCountHeight = font*3*(model.showCount-1);
        for (int i=0; i<model.showCount; i++) {
            CGFloat contentSpace = font*3;
            if (i%2==0) {
                contentSpace = 0;
            }
            [model.content drawInRect:CGRectMake((endImgSize.width-textSize.width-showCountzero)/2+contentSpace, (endImgSize.height-textSize.height*model.showCount-showCountHeight)/2+textH*i, textSize.width, textSize.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font], NSForegroundColorAttributeName:textColor}];
            
        }
    }
    else{
        //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
        CGFloat orignX = -(sqrtLength-endImgSize.width)/2;
        CGFloat orignY = -(sqrtLength-endImgSize.height)/2;
        
        // 绘制文字(正常)
        for (int i=0; i<ceil(sqrtLength/(textSize.height)); i++) {
            for (int j=0; j<ceil(sqrtLength/textSize.width); j++) {
                CGFloat contentSpace = 0;
                if (i%2==0) {
                    contentSpace = font*3;
                }
                [model.content drawInRect:CGRectMake(orignX+textW*j+contentSpace, orignY+textH*i, textSize.width, textSize.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font], NSForegroundColorAttributeName:textColor,NSParagraphStyleAttributeName:style}];
            }
        }
    }
    
    // 生成水印图片
    UIImage *waterMarkImg = UIGraphicsGetImageFromCurrentImageContext();
    // 结束画布
    UIGraphicsEndImageContext();
    // 返回图片
    return waterMarkImg;
    
}


//#pragma mark 加文字水印
//+ (UIImage *)addText:(NSString *)text inImage:(UIImage *)image fontSize:(CGFloat)fontSize angle:(CGFloat)angle endImgSize:(CGSize)endImgSize textLineSpaceing:(CGFloat)textLineSpaceing red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
//{
//    //如果图片不需要那么大的话,可以缩小画布的大小
////    endImgSize.width = endImgSize.width/[UIScreen mainScreen].scale;
////    endImgSize.height = endImgSize.height/[UIScreen mainScreen].scale;
//    // 开启上下文
//    UIGraphicsBeginImageContext(CGSizeMake(endImgSize.width, endImgSize.height));//这种方式会模糊
////    UIGraphicsBeginImageContextWithOptions(endImgSize, NO, [UIScreen mainScreen].scale);//高清
//    // 绘制底部图片
//    [image drawInRect:CGRectMake(0, 0, endImgSize.width, endImgSize.height)];
//    // 水印图片
//    UIImage *waterMarkImg = [self addText:text fontSize:fontSize angle:angle endImgSize:endImgSize textLineSpaceing:textLineSpaceing red:red green:green blue:blue alpha:alpha];
//    // 绘制水印
////    [waterMarkImg drawInRect:CGRectMake(-endImgSize.height, -endImgSize.height, endImgSize.height*5, endImgSize.height*5)];
//    [waterMarkImg drawInRect:CGRectMake(0, 0, endImgSize.width, endImgSize.height)];
//    // 生成图片
//    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
//    // 结束画布
//    UIGraphicsEndImageContext();
//    // 返回图片
//    return newImg;
//
//}

//#pragma mark 水印图片生成
//+ (UIImage *)addText:(NSString *)text fontSize:(CGFloat)fontSize angle:(CGFloat)angle endImgSize:(CGSize)endImgSize textLineSpaceing:(CGFloat)textLineSpaceing red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
//    // 扩大字体
//    CGFloat font = fontSize*[UIScreen mainScreen].scale;
//    //对角线
//    CGFloat sqrtLength = sqrt(endImgSize.width*endImgSize.width + endImgSize.height*endImgSize.height);
//
//    // 开启画布
//    UIGraphicsBeginImageContext(CGSizeMake(endImgSize.width, endImgSize.height));//这种方式会模糊,文字可以不用那么高清
////    UIGraphicsBeginImageContextWithOptions(CGSizeMake(endImgSize.width, endImgSize.height), NO, [UIScreen mainScreen].scale);//这种高清的
//    //开始旋转上下文矩阵，绘制水印文字
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    //将绘制原点（0，0）调整到源image的中心
//    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(endImgSize.width/2, endImgSize.height/2));
//    //以绘制原点为中心旋转
//    CGContextConcatCTM(context, CGAffineTransformMakeRotation(angle*M_PI*2/360));
//    //将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
//    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-endImgSize.width/2, -endImgSize.height/2));
//
//    // 设置颜色
//    [[UIColor clearColor] set];
//    //设置文字的颜色以及透明度
//    UIColor * textColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
//
//    //设置水印字体的行间距
////    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//
//    // 文字size
//    CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
//
////     文字绘制区域长度
//    CGFloat textW = textSize.width + font;
//
//    // 文字绘制区域高度
//    CGFloat textH = textSize.height + font;
//    //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
//    CGFloat orignX = -(sqrtLength-endImgSize.width)/2;
//    CGFloat orignY = -(sqrtLength-endImgSize.height)/2;
//
//    // 绘制文字
//    for (int i=0; i<ceil(endImgSize.height/(textSize.height)); i++) {
//        for (int j=0; j<ceil(endImgSize.width*2/textSize.width); j++) {
//            [text drawInRect:CGRectMake(orignX+textW*j, orignY+textH*i, textSize.width, textSize.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font], NSForegroundColorAttributeName:textColor}];
//        }
//    }
//
//    // 生成水印图片
//    UIImage *waterMarkImg = UIGraphicsGetImageFromCurrentImageContext();
//
//    // 结束画布
//    UIGraphicsEndImageContext();
//    // 返回图片
//    return waterMarkImg;
//}

//
//+(UIImage *)waterMarkImageSize:(CGSize)endImgSize withCustomModel:(WaterMarkMode*)model{
//
//    // 扩大字体
//    CGFloat font = model.fontSize;
//    //对角线
//    CGFloat sqrtLength = sqrt(endImgSize.width*endImgSize.width + endImgSize.height*endImgSize.height);
//
//    // 开启画布
//    UIGraphicsBeginImageContext(CGSizeMake(endImgSize.width, endImgSize.height));//这种方式会模糊
//    //    UIGraphicsBeginImageContextWithOptions(CGSizeMake(wh, wh), NO, [UIScreen mainScreen].scale);//这种高清的
//    //开始旋转上下文矩阵，绘制水印文字
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    //将绘制原点（0，0）调整到源image的中心
//    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(endImgSize.width/2, endImgSize.height/2));
//    //以绘制原点为中心旋转
//    CGContextConcatCTM(context, CGAffineTransformMakeRotation(model.roration*M_PI*2/360));
//    //将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
//    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-endImgSize.width/2, -endImgSize.height/2));
//
//    // 设置颜色
//    [[UIColor clearColor] set];
//    //设置文字的颜色以及透明度
//    UIColor * textColor = [UIColor colorWithRed:model.red green:model.green blue:model.blue alpha:model.alpha];
//
//    //设置水印字体的行间距
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//
//    // 文字size
//    CGSize textSize = [model.content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
//    NSLog(@"文字的大小%@",NSStringFromCGSize(textSize));
//    //     文字绘制区域长度
//    CGFloat textW = textSize.width + font*3;//空3个字符
//    // 文字绘制区域高度
//    CGFloat textH = textSize.height + font*3;//空三行
//
//    //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
//    CGFloat orignX = -(sqrtLength-endImgSize.width)/2;
//    CGFloat orignY = -(sqrtLength-endImgSize.height)/2;
//
//    // 绘制文字
//    for (int i=0; i<ceil(sqrtLength/(textSize.height)); i++) {
//        for (int j=0; j<ceil(sqrtLength/textSize.width); j++) {
//            CGFloat contentSpace = 0;
//            if (i%2==0) {
//                contentSpace = font*3;
//            }
//            [model.content drawInRect:CGRectMake(orignX+textW*j+contentSpace, orignY+textH*i, textSize.width, textSize.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font], NSForegroundColorAttributeName:textColor,NSParagraphStyleAttributeName:style}];
//        }
//    }
//    // 生成水印图片
//    UIImage *waterMarkImg = UIGraphicsGetImageFromCurrentImageContext();
//    // 结束画布
//    UIGraphicsEndImageContext();
//    // 返回图片
//    return waterMarkImg;
//
//}


#pragma mark- 缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width/scaleSize,image.size.height/scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width / scaleSize, image.size.height /scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}



/**
 从指定的rect裁剪出图片
 */
- (UIImage *)clipImageWithRect:(CGRect)rect{
    
    CGFloat hscale = self.size.height/kScreenHeight;
    CGFloat wscale = self.size.width/kScreenWidth;
    CGImageRef clipImageRef = CGImageCreateWithImageInRect(self.CGImage,
                                                           CGRectMake(rect.origin.x * wscale,
                                                                      rect.origin.y  * hscale,
                                                                      rect.size.width * wscale,
                                                                      rect.size.height * hscale));
    return [UIImage imageWithCGImage:clipImageRef];
}

//缩小图片到指定大小
- (UIImage *)scaleImageWithSize:(CGSize)size{
    
    //创建上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width*kDeviceScale,size.height*kDeviceScale), NO, kDeviceScale);
    
    //绘图
    [self drawInRect:CGRectMake(0, 0, size.width*kDeviceScale, size.height*kDeviceScale)];
    
    //获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
