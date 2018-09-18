//
//  UIImage+CellImage.h
//  PictureBook
//
//  Created by 陈松松 on 2018/4/25.
//  Copyright © 2018年 zaoliedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CellImage)
+ (UIImage *)cellImageWithUrl:(NSURL *)url backgroundImage:(UIImage *)background;
@end
