//
//  BusinessLicenseViewController.h
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Base1ViewController.h"

@protocol CameraDelegate <NSObject>

- (void)CameraTakePhoto:(UIImage *)image;

@end

@interface BusinessLicenseViewController : Base1ViewController


@property (nonatomic, weak)id<CameraDelegate> delegate;

@end
