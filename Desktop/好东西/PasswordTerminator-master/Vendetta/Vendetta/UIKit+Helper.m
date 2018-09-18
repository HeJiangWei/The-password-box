//
//  UIKit+Helper.m
//  Vendetta
//
//  Created byjw chen JW on 15/8/18.
//  Copyright (c) 2018年 chen Yuheng. All rights reserved.
//

#import "UIKit+Helper.h"

@interface UIKitHelper ()

@end

@implementation UIKitHelper

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(UIKitHelper*)sharedInstance
{
    static dispatch_once_t  onceToken;
    static UIKitHelper * sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UIKitHelper alloc] init];
    });
    return sharedInstance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

//获取视图的视图控制器
+ (UIViewController*)viewControllerOfSuperView:(UIView *)subView
{
    for (UIView *next = [subView superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

//根据颜色生成图片
+ (UIImage *) imageFromColor:(UIColor *)color andFrame:(CGRect) rect{
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (CGFloat) getTextWidthWithText:(NSString *) text andMaxHeight:(CGFloat) maxHeight andFont:(UIFont *) font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHeight) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return ceilf(size.width);
}

+ (CGFloat) getTextHeightWithText:(NSString *) text andMaxWidth:(CGFloat) maxWidth andFont:(UIFont *) font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxWidth,MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return ceilf(size.height);
}

+ (CGFloat) getTextHeightWithAttributedText:(NSAttributedString *)attributedString
{
    UITextView *tmp = [[UITextView alloc]init];
    tmp.attributedText = attributedString;
    [tmp sizeToFit];
    return tmp.frame.size.height;
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
@end
