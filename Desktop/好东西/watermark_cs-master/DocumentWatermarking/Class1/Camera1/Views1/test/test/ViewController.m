//
//  ViewController.m
//  test
//
//  Created by apple on 2017/11/15.
//  Copyright © 2017年 com.zhuogg. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
{
    CGFloat lastScale;
    CGRect oldFrame;    //保存图片原来的大小
    CGRect largeFrame;  //确定图片放大最大的程度
    CGAffineTransform transform;//缩放的最小form
}
@property(nonatomic,strong)UIImageView *imgView;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(15, 100, self.view.frame.size.width-30, 200)];
    view.layer.borderWidth=1;
    view.layer.borderColor = [UIColor blueColor].CGColor;
    self.imgView = [[UIImageView alloc]initWithFrame:view.bounds];
    
    self.imgView.image = [UIImage imageNamed:@"fengmian"];
    oldFrame = self.imgView.frame;
    transform = CGAffineTransformIdentity;
    [view addSubview:self.imgView];
    view.clipsToBounds = YES;
    [self.view addSubview:view];
    //图片允许交互,别忘记设置,否则手势没有反应
    self.imgView.userInteractionEnabled = NO;
    
    
    //旋转
    UIRotationGestureRecognizer *rotaitonGest = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationView:)];
    rotaitonGest.delegate =self;
    [view addGestureRecognizer:rotaitonGest];
    
    //捏合
    UIPinchGestureRecognizer *pinchGest = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGest];
    
    //拖拽
    UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGest];
}

-(void)rotationView:(UIRotationGestureRecognizer *)rotationGest{
    
    //旋转角度
    //旋转的角度也一个累加的过程
    NSLog(@"旋转角度 %f",rotationGest.rotation);
    
    // 设置图片的旋转
    self.imgView.transform = CGAffineTransformRotate(self.imgView.transform, rotationGest.rotation);
    // 清除 "旋转角度" 的累
    rotationGest.rotation = 0;
    
}

-(void)pinchView:(UIPinchGestureRecognizer *)pinchGest{
    //设置图片缩放
    NSLog(@"缩放的手势scale=%f",pinchGest.scale);
//    if (self.imgView.frame.size.width < oldFrame.size.width) {
////        self.imgView.transform = CGAffineTransformScale(self.imgView.transform, 1, 1);
//
//    }
//    else{

    NSLog(@"image的frame%@",NSStringFromCGRect(self.imgView.frame));
//    }

        self.imgView.transform = CGAffineTransformScale(self.imgView.transform, pinchGest.scale, pinchGest.scale);
        transform = self.imgView.transform;
    

    // 还源
    pinchGest.scale = 1;
}

-(void)panView:(UIPanGestureRecognizer *)panGest{
    
    //拖拽的距离(距离是一个累加)
    CGPoint trans = [panGest translationInView:panGest.view];
    CGPoint velocityTrans = [panGest velocityInView:panGest.view];
    
    NSLog(@"图片的坐标%@\n中心点的坐标是%@\n拖拽的坐标%@\n速率坐标%@",NSStringFromCGRect(self.imgView.frame),NSStringFromCGPoint(self.imgView.center),NSStringFromCGPoint(trans),NSStringFromCGPoint(velocityTrans));
    //设置图片移动
    CGPoint center =  self.imgView.center;
    center.x += trans.x;
    center.y += trans.y;
    
    self.imgView.center = center;
    
    //清除累加的距离
    [panGest setTranslation:CGPointZero inView:panGest.view];
    
//    if (panGest.state ==UIGestureRecognizerStateEnded) {
//        CGPoint velocity = [panGest velocityInView:self.view];
//        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
//        CGFloat slideMult = magnitude / 200;
//        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
//
//        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
//        CGPoint finalPoint = CGPointMake(panGest.view.center.x + (velocity.x * slideFactor),
//                                         panGest.view.center.y + (velocity.y * slideFactor));
//        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
//        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
//        self.imgView.center = finalPoint;
//    }
}

/**
 *  多个手势同时存在的代理,不能忘记
 */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
    
}


@end
