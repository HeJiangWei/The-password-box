//
//  ClipViewController.h
//  Camera
//
//  Created by wzh on 2017/6/6.
//  Copyright © 2017年 wzh. All rights reserved.
//

#import "Base1ViewController.h"

//@protocol ClipPhotoDelegate <NSObject>
//
//- (void)clipPhoto:(UIImage *)image;
//
//@end

static inline float change2Radians(double degrees) { return degrees * M_PI / 180; }
static inline float change2Angle(double rad) { return rad *  180 / M_PI; }

@interface ClipViewController : Base1ViewController
@property (strong, nonatomic) UIImage *image;

//@property (nonatomic, strong) UIImagePickerController *picker;
//
//@property (nonatomic, strong) UIViewController *controller;
//
//@property (nonatomic, weak) id<ClipPhotoDelegate> delegate;
//
//@property (nonatomic, assign) BOOL isTakePhoto;

@end
