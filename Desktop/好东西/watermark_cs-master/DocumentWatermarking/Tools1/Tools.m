//
//  Tools.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Tools.h"
#import <Foundation/Foundation.h>
#import <sys/utsname.h>
#import <CommonCrypto/CommonDigest.h>
#import "PopGessture1Tip.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "AleartView.h"

@implementation Tools





//截取指定视图的图片
+(UIImage *)imageFromView:(UIView*)theView{
    
    NSLog(@"%f", [UIScreen mainScreen].scale);
    UIGraphicsBeginImageContextWithOptions(theView.frame.size, NO, kDeviceScale);//开启高清模式
    
//    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;

}
//裁剪指定区域图片
+(UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r{
    
//    UIGraphicsBeginImageContextWithOptions(r.size, NO, 0.0);
////    UIGraphicsBeginImageContext(theView.frame.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
//    UIRectClip(r);
//    [theView.layer renderInContext:context];
//
//    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return  theImage;//[self getImageAreaFromImage:theImage atFrame:r];
//    UIGraphicsBeginImageContextWithOptions(theView.frame.size, NO, 0.0);
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIRectClip(r);
    CGContextSaveGState(context);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
    
}
//裁剪图片
+(UIImage*)imageFromeImage:(UIImage*)image andRect:(CGRect)rect{
    //1.获取图片
    //2.开启图形上下文
    CGSize size = CGSizeMake(image.size.width/kDeviceScale, image.size.height/kDeviceScale);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //3.绘制到图形上下文中
    [image drawInRect:rect];
    //4.从上下文中获取图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
    
    
}

//获得某个范围内的图像
+ (UIImage *)imageFromImage: (UIImage *) image   atFrame:(CGRect)r{
    
//    UIGraphicsBeginImageContext(size)
//    image.drawInRect(CGRectMake(0, 0, size.width, size.height))
//    var newImage=UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    return newImage
    
//    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
//    [image drawInRect:CGRectMake(0, 0, r.size.width, r.size.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;

    UIGraphicsBeginImageContextWithOptions(image.size,NO,image.scale);
    r.origin.x = r.origin.x*kDeviceScale;
    r.origin.y = r.origin.y *kDeviceScale;
    r.size.width = r.size.width*kDeviceScale;
    r.size.height = r.size.height*kDeviceScale;
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, r);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    return newImage;
    
}
//处理图片旋转的问题
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    
    
    // No-op if the orientation is already correct
    
    if (aImage.imageOrientation ==UIImageOrientationUp)
        
        return aImage;
    
    
    
    // We need to calculate the proper transformation to make the image upright.
    
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    
    CGAffineTransform transform =CGAffineTransformIdentity;
    
    
    
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationDown:
            
        case UIImageOrientationDownMirrored:
            
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            
            transform = CGAffineTransformRotate(transform, M_PI);
            
            break;
            
            
            
        case UIImageOrientationLeft:
            
        case UIImageOrientationLeftMirrored:
            
            transform = CGAffineTransformTranslate(transform, aImage.size.width,0);
            
            transform = CGAffineTransformRotate(transform, M_PI_2);
            
            break;
            
            
            
        case UIImageOrientationRight:
            
        case UIImageOrientationRightMirrored:
            
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            
            break;
            
        default:
            
            break;
            
    }
    
    
    
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationUpMirrored:
            
        case UIImageOrientationDownMirrored:
            
            transform = CGAffineTransformTranslate(transform, aImage.size.width,0);
            
            transform = CGAffineTransformScale(transform, -1, 1);
            
            break;
            
            
            
        case UIImageOrientationLeftMirrored:
            
        case UIImageOrientationRightMirrored:
            
            transform = CGAffineTransformTranslate(transform, aImage.size.height,0);
            
            transform = CGAffineTransformScale(transform, -1, 1);
            
            break;
            
        default:
            
            break;
            
    }
    
    
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    
    // calculated above.
    
    CGContextRef ctx =CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                            
                                            CGImageGetBitsPerComponent(aImage.CGImage),0,
                                            
                                            CGImageGetColorSpace(aImage.CGImage),
                                            
                                            CGImageGetBitmapInfo(aImage.CGImage));
    
    CGContextConcatCTM(ctx, transform);
    
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationLeft:
            
        case UIImageOrientationLeftMirrored:
            
        case UIImageOrientationRight:
            
        case UIImageOrientationRightMirrored:
            
            // Grr...
            
            CGContextDrawImage(ctx,CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            
            break;
            
            
            
        default:
            
            CGContextDrawImage(ctx,CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            
            break;
            
    }
    
    
    
    // And now we just create a new UIImage from the drawing context
    
    CGImageRef cgimg =CGBitmapContextCreateImage(ctx);
    
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    
    CGContextRelease(ctx);
    
    CGImageRelease(cgimg);
    
    return img;
    
}

//图片合成
+(UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 andSpace:(CGFloat)space{
    
    CGSize size = CGSizeMake(image1.size.width>image2.size.width?image1.size.width*kDeviceScale:image2.size.width*kDeviceScale, image1.size.height*kDeviceScale+image2.size.height*kDeviceScale+space*kDeviceScale);
    //    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, kDeviceScale);
    
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width*kDeviceScale, image1.size.height*kDeviceScale)];
    
    // Draw image2
    [image2 drawInRect:CGRectMake(0, image1.size.height*kDeviceScale+space*kDeviceScale, image2.size.width*kDeviceScale, image2.size.height*kDeviceScale)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}


//图片合成
+(UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2{
    
    CGSize size = CGSizeMake(image1.size.width>image2.size.width?image1.size.width*kDeviceScale:image2.size.width*kDeviceScale, image1.size.height*kDeviceScale+image2.size.height*kDeviceScale+5);
//    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, kDeviceScale);

    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width*kDeviceScale, image1.size.height*kDeviceScale)];
    
    // Draw image2
    [image2 drawInRect:CGRectMake(0, image1.size.height*kDeviceScale+5, image2.size.width*kDeviceScale, image2.size.height*kDeviceScale)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

//图片灰度处理
+(UIImage *)convertImageToGreyScale:(UIImage *)image{

    const int RED =1;
    const int GREEN =2;
    const int BLUE =3;
    
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0,0, image.size.width* image.scale, image.size.height* image.scale);
    
    int width = imageRect.size.width;
    int height = imageRect.size.height;
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t*) malloc(width * height *sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels,0, width * height *sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height,8, width *sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context,CGRectMake(0,0, width, height), [image CGImage]);
    
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t*) &pixels[y * width + x];
            
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] +0.59 * rgbaPixel[GREEN] +0.11 * rgbaPixel[BLUE];
            
            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:UIImageOrientationUp];
    
    // we're done with image now too
    CGImageRelease(imageRef);
    
    return resultUIImage;
}


+(NSString *)deviceString{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])  return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])  return@"iPhone Simulator";
    
    return platform;

}

//md5加密
+ (NSString *)stringToMD5:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


//获取当前时间戳  （以毫秒为单位）
+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    return timeSp;
    
}

NSString*safeString(id string){
    if (IsNilOrNull(string)) {
        return @" ";
    }
    return [NSString stringWithFormat:@"%@",string];
}

//设置图片的锚点
+ (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

//设置回原来的锚点
+ (void)setDefaultAnchorPointforView:(UIView *)view
{
    [self setAnchorPoint:CGPointMake(0.5f, 0.5f) forView:view];
}

//显示手势的提示
+(void)showGessTipView{

    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:kTipGessShow];
    if (string!=nil&&[string isEqualToString:@"tipshowGess"]) {
        
    }
    else{
        
        [[NSUserDefaults standardUserDefaults] setObject:@"tipshowGess" forKey:kTipGessShow];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        PopGessture1Tip *popgesstip = [[PopGessture1Tip alloc]initWithShowFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andAlpha:0.5];
        [popgesstip show];
    }
}

//显示提示框的提示
+(void)showAleartView:(UIEdgeInsets)edge{
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:kTipGessShow];
    if (string!=nil&&[string isEqualToString:@"tipshowGess"]) {
        
        NSString *aleartString = [[NSUserDefaults standardUserDefaults] objectForKey:kAleartViewShow];
        if (aleartString!=nil&&[aleartString isEqualToString:@"aleartViewShow"]) {
            
        }
        else{
            [[NSUserDefaults standardUserDefaults] setObject:@"aleartViewShow" forKey:kAleartViewShow];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            AleartView *aleartView = [[AleartView alloc]initWithShowFrame:CGRectMake(kScreenWidth-172, kScreenHeight-130-edge.bottom, 160, 50) andAlpha:0];
            [aleartView show];
        }
    }
    else{
    }
}


/**
 *  拍照
 *
 *  @param viewController 代理控制器
 */
+(void) takePhoto:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)viewController
{
    [Tools acquireMediaType:AVMediaTypeVideo Auth:^(BOOL grant){
        
        if (grant) {
            
            if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])) {
                UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
                cameraUI.delegate = viewController;
                cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
                cameraUI.allowsEditing = YES;
                if([[[UIDevice
                      currentDevice] systemVersion] floatValue]>=8.0) {
                    ((UIViewController *)viewController).modalPresentationStyle=UIModalPresentationOverCurrentContext;
                }
                
                [(UIViewController *)viewController presentViewController:cameraUI animated:YES completion:nil];
                
            }
            else {
            }
        }
        
    }];
}

/**
 *  单相片选择
 *
 *  @param viewController 代理控制器
 */
+(void)selectOnePhoto:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)viewController{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    NSLog(@"状态%zd",author);
    
    if(author ==ALAuthorizationStatusRestricted){
        //此应用程序没有被授权访问的照片数据
        
    }
    else if(author == ALAuthorizationStatusDenied){
        
        // 用户已经明确否认了这一照片数据的应用程序访问
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                              
                                                        message:@"您已设置不允许访问相册,请在设备的设置-隐私-照片中允许访问照片。"
                              
                                                       delegate:nil
                              
                                              cancelButtonTitle:@"确定"
                              
                                              otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    else if(author == ALAuthorizationStatusAuthorized){
        //允许访问
    }else{
        //用户尚未做出了选择这个应用程序的问候
    }
    
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])) {
        UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
        cameraUI.delegate = viewController;
        cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        cameraUI.allowsEditing = NO;
        if([[[UIDevice
              currentDevice] systemVersion] floatValue]>=8.0) {
            ((UIViewController *)viewController).modalPresentationStyle=UIModalPresentationOverCurrentContext;
        }
        [(UIViewController *)viewController presentViewController:cameraUI animated:YES completion:nil];
    }
}

/**
 *  请求相机权限
 *
 *  @param mediaType 类型
 *  @param block     返回值
 */
+(void)acquireMediaType:(NSString *)mediaType Auth:(void (^)(BOOL grant))block;
{
    
    [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ( granted ) {
                block(YES);
            }
            else {
                
                block (NO);
            }
        });
        
    }];
}

/**
 *  请求相册权限
 *
 *  @param block     返回值
 */
+(void)acquirePhotoAuth:(void (^)(BOOL grant))block
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
        dispatch_async(dispatch_get_main_queue(), ^{

        if (status == PHAuthorizationStatusAuthorized) {
            //这里就是用权限
            block(YES);
        }  else {
            // 这里便是无访问权限
            //可以弹出个提示框，叫用户去设置打开相册权限
            block(NO);
        }
        });

    }];
    
}

@end
