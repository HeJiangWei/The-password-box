//
//  CupTwoView.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CupTwoView.h"

#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

#define ORIGINAL_MAX_WIDTH 640.0f

@interface CupTwoView()
{
    UILabel *showClickLabel;//点击拍照文字
    UILabel *showClickLabel2;//点击拍照文字
    CGFloat _topspace;
}

@property(nonatomic,strong)CAShapeLayer *vertulLineLayer;
@property(nonatomic,strong)CAShapeLayer *fillLayer;
@property(nonatomic,strong)CAShapeLayer *vertulLineLayer2;
@property(nonatomic,strong)UIView *showGrayView2;//装载点击拍照,还没拍照之前的视图

@end

@implementation CupTwoView
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self configer];
        [self initView];
    }
    return self;
}
//初始化
- (void)configer{
    
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
//    self.lineWidth = 1;
//    self.lineColor = [UIColor clearColor];
//    self.cupBezPath.lineWidth = self.lineWidth;
    
    CGFloat height =0;
    CGFloat leftSpace = 15.0;
    CGFloat Space = 16.0;
    CGFloat width = 0;
    height = (self.frame.size.height-3*16.0)/2.0;
    //这样算出来的高大于屏幕的高,那么就要按照屏幕的高来算框的宽
    if ((kScreenWidth-2*leftSpace)*54/85.6*2>(self.frame.size.height)) {
        
        height = (self.frame.size.height-3*Space)/2.0;
        width = height*85.6/54.0;
        if (width+2*leftSpace>kScreenWidth) {
            width = (kScreenWidth-2*leftSpace);
            height = width*54.0/85.6;
            Space = (self.frame.size.height-2*height)/3.0;
        }
        leftSpace = (kScreenWidth-width)/2.0;
        
    }else{
        //屏幕的高不大于
        height = (self.frame.size.height-3*Space)/2.0;
        width = height*85.6/54.0;
        if (width+2*leftSpace>kScreenWidth) {
            width = kScreenWidth - 2*leftSpace;
            height = width*54.0/85.6;
            Space = (self.frame.size.height-2*height)/3.0;
        }
        leftSpace = (kScreenWidth-width)/2.0;
    }
    
    self.WillCupRect = CGRectMake(leftSpace, Space, width, height);
    self.WillCupRect2 = CGRectMake(leftSpace, CGRectGetMaxY(self.WillCupRect)+Space, width, height);
    
}

/*
 *  shezhishitu
 */
-(void)initView{
//    WeakSelf;
    _shwoView = [[ImageShowView alloc]initWithFrame:self.WillCupRect andTakePhoto:YES andSelectBlock:^(ImageShowView *imageScrollView) {
        NSLog(@"------------上上上");
        //        if (_shwoView2.isSetImage&&_shwoView.isSetImage) {
        //            //两张都拍照了,那么进行灰色图层的显示
        //            //第一个删掉
        //            [_shwoView.showGrayView removeFromSuperview];
        //            //显示第2个
        //            [_shwoView2 setGrayView];
        //            _shwoView2.rotaitonGest.enabled = NO;
        //            _shwoView2.panGest.enabled = NO;
        //            _shwoView2.pinchGest.enabled = NO;
        //            _shwoView.rotaitonGest.enabled = YES;
        //            _shwoView.panGest.enabled = YES;
        //            _shwoView.pinchGest.enabled = YES;
        //
        //        }
        //        if (!_shwoView.isSetImage) {
        //            //如果第一个没有设置图片,那么就吧点击拍照去掉
        //            [_shwoView.showClickView removeFromSuperview];
        //
        //        }
        //        if (!_shwoView2.isSetImage) {
        //            [_shwoView2 setClickView:@"拍照反面"];
        //        }
        if (_takePhotoBlack) {
            _takePhotoBlack(_shwoView,1);
        }
        
    }];
    _shwoView.userInteractionEnabled = YES;
    _shwoView.isTop = YES;
    //    [_shwoView.showClickView removeFromSuperview];
    [self addSubview:_shwoView];
    
    _shwoView2 = [[ImageShowView alloc]initWithFrame:self.WillCupRect2 andTakePhoto:YES andSelectBlock:^(ImageShowView *imageScrollView) {
        NSLog(@"------------下下下");
        //        if (_shwoView2.isSetImage&&_shwoView.isSetImage) {
        //            //两张都拍照了,那么进行灰色图层的显示
        //            //第2个删掉
        //            [_shwoView2.showGrayView removeFromSuperview];
        //            //显示第一个
        //            [_shwoView setGrayView];
        //            _shwoView.rotaitonGest.enabled = NO;
        //            _shwoView.panGest.enabled = NO;
        //            _shwoView.pinchGest.enabled = NO;
        //            _shwoView2.rotaitonGest.enabled = YES;
        //            _shwoView2.panGest.enabled = YES;
        //            _shwoView2.pinchGest.enabled = YES;
        //
        //
        //        }
        //        if (!_shwoView2.isSetImage) {
        //            //如果第二个没有设置图片,那么就吧点击拍照去掉
        //            [_shwoView2.showClickView removeFromSuperview];
        //        }
        //        if (!_shwoView.isSetImage) {
        //            [_shwoView setClickView:@"拍照正面"];
        //        }
        //
        if (_takePhotoBlack) {
            _takePhotoBlack(_shwoView2,0);
        }
        
    }];
    _shwoView2.userInteractionEnabled = YES;
    _shwoView2.isTop = NO;
    //    [_shwoView2 setClickView:@"拍照反面"];
    [self addSubview:_shwoView2];
    
}

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) cornerRadius:0];
    
    self.cupBezPath = [UIBezierPath bezierPathWithRoundedRect:self.WillCupRect cornerRadius:0];
    self.cupBezPath2 = [UIBezierPath bezierPathWithRoundedRect:self.WillCupRect2 cornerRadius:0];
    
    [path appendPath:_cupBezPath];
    [path appendPath:_cupBezPath2];
    
    [path setUsesEvenOddFillRule:YES];
    _fillLayer = [CAShapeLayer layer];
    
    _fillLayer.path = path.CGPath;
    
    //中间透明
    _fillLayer.fillRule = kCAFillRuleEvenOdd;
    //半透明效果
    _fillLayer.fillColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    
    [self.layer addSublayer:_fillLayer];
    
//    //绘制虚线边框
//    _vertulLineLayer = [CAShapeLayer layer];
//
//    _vertulLineLayer.path = self.cupBezPath.CGPath;
//    _vertulLineLayer.strokeColor = [UIColor whiteColor].CGColor;
//    _vertulLineLayer.fillColor = [UIColor clearColor].CGColor;
//    _vertulLineLayer.lineCap = kCALineCapRound;
//    _vertulLineLayer.lineWidth = 1;
//    [self.layer addSublayer:_vertulLineLayer];
//    //绘制虚线边框
//    _vertulLineLayer2 = [CAShapeLayer layer];
//
//    _vertulLineLayer2.path = self.cupBezPath2.CGPath;
//    _vertulLineLayer2.strokeColor = [UIColor whiteColor].CGColor;
//    _vertulLineLayer2.fillColor = [UIColor clearColor].CGColor;
//    _vertulLineLayer2.lineCap = kCALineCapRound;
//    _vertulLineLayer2.lineWidth = 1;
//    [self.layer addSublayer:_vertulLineLayer2];
    
}

//- (UIImage *)clipImageWithSoucreImageView:(UIImageView *)imageView{
//
//    CGRect foreCupRect = CGRectMake((KWidth-KCupWidth)/2, (KHeight-KCupHeight)/2, KCupWidth, KCupHeight);
//
//    CGRect soucreRect = imageView.frame;
//
//    UIImage *soucreImage = imageView.image;
//
//    float zoomScale = [[imageView.layer valueForKeyPath:@"transform.scale.x"] floatValue];
//    float rotate = [[imageView.layer valueForKeyPath:@"transform.rotation.z"] floatValue];
//
//    float _imageScale = soucreImage.size.width / KCupWidth;
//
//
//    CGSize cropSize = CGSizeMake((foreCupRect.size.width)/zoomScale, (foreCupRect.size.height)/zoomScale);
//
//    CGPoint cropperViewOrigin = CGPointMake((foreCupRect.origin.x - soucreRect.origin.x)/zoomScale,
//                                            (foreCupRect.origin.y - soucreRect.origin.y)/zoomScale);
//
//    if((NSInteger)cropSize.width % 2 == 1)
//    {
//        cropSize.width = ceil(cropSize.width);
//    }
//    if((NSInteger)cropSize.height % 2 == 1)
//    {
//        cropSize.height = ceil(cropSize.height);
//    }
//
//
//    CGRect CropRectinImage = CGRectMake((NSInteger)(cropperViewOrigin.x)*_imageScale/2 ,(NSInteger)( cropperViewOrigin.y)*_imageScale/2, (NSInteger)(cropSize.width)*_imageScale/2,(NSInteger)(cropSize.height)*_imageScale/2);
//
//    UIImage *rotInputImage = [soucreImage imageRotatedByRadians:rotate];
//
//    CGImageRef tmp = CGImageCreateWithImageInRect([rotInputImage CGImage], CropRectinImage);
//    UIImage *resultImage = [UIImage imageWithCGImage:tmp scale:soucreImage.scale orientation:soucreImage.imageOrientation];
//
//    if (!resultImage) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您剪切的区域无效，请重新剪切" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        return nil;
//    }
//
//    CGRect imageRect = CGRectZero;
//    imageRect.size = resultImage.size;
//
//    UIBezierPath *cupedPath;
//    UIGraphicsBeginImageContextWithOptions(imageRect.size, YES, 0.0);
//    {
//        [[UIColor blackColor] setFill];
//        UIRectFill(imageRect);
//
//        [[UIColor whiteColor] setFill];
//        cupedPath = [UIBezierPath bezierPathWithOvalInRect:imageRect];
//        [cupedPath fill];
//    }
//    UIImage *maskImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//
//    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, 0.0);
//    {
//        CGContextClipToMask(UIGraphicsGetCurrentContext(), imageRect, maskImage.CGImage);
//        [resultImage drawAtPoint:CGPointZero];
//    }
//    UIImage *maskResultImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return maskResultImage;
//
//}
//
//
///* 图片规定大小 */
//- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
//    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
//    CGFloat btWidth = 0.0f;
//    CGFloat btHeight = 0.0f;
//    if (sourceImage.size.width > sourceImage.size.height) {
//        btHeight = ORIGINAL_MAX_WIDTH;
//        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
//    } else {
//        btWidth = ORIGINAL_MAX_WIDTH;
//        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
//    }
//    CGSize targetSize = CGSizeMake(btWidth, btHeight);
//
//    return [self scaleToSize:sourceImage size:targetSize];
//}
//
///*  去除图片本身自带方向 */
//- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    UIGraphicsBeginImageContext(size);
//    // 绘制改变大小的图片
//    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    // 从当前context中创建一个改变大小后的图片
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//    // 返回新的改变大小后的图片
//    return scaledImage;

@end

