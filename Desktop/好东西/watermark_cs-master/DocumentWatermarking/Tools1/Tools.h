//
//  Tools.h
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject
//裁剪图片
+(UIImage*)imageFromeImage:(UIImage*)image andRect:(CGRect)rect;
//截取指定视图的图片
+(UIImage *)imageFromView:(UIView*)theView;
//获得某个范围内的屏幕图像
+ (UIImage *)imageFromView: (UIView *) theView   atFrame:(CGRect)r;
//获得某个范围内的图像
+ (UIImage *)imageFromImage: (UIImage *) image   atFrame:(CGRect)r;
//处理图片旋转的问题
+ (UIImage *)fixOrientation:(UIImage *)aImage ;
//图片合成
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 ;
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 andSpace:(CGFloat)space;

//照片转黑白
+ (UIImage*) convertImageToGreyScale:(UIImage*) image;

//获取设备
+(NSString *)deviceString;

/**
 MD5加密
 */
+ (NSString *)stringToMD5:(NSString *)string;
//获取当前时间戳  （以毫秒为单位）
+ (NSString *)getNowTimeTimestamp;

NSString*safeString(id string);

//设置图片的锚点
+ (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view;
//设置回原来的锚点
+ (void)setDefaultAnchorPointforView:(UIView *)view;

//显示手势的提示
+(void)showGessTipView;

//显示提示框的提示
+(void)showAleartView:(UIEdgeInsets)edge;

/**
 *  拍照
 *
 *  @param viewController 代理控制器
 */
+(void) takePhoto:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)viewController;
/**
 *  单相片选择
 *
 *  @param viewController 代理控制器
 */
+(void)selectOnePhoto:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)viewController;

//相机权限问题
+(void)acquireMediaType:(NSString *)mediaType Auth:(void (^)(BOOL grant))block;
/**
 *  请求相册权限
 */
+(void)acquirePhotoAuth:(void (^)(BOOL grant))block;
@end
