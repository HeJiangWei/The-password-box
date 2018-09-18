//
//  ClipViewController.m
//  Camera
//
//  Created by wzh on 2017/6/6.
//  Copyright © 2017年 wzh. All rights reserved.
//

#import "ClipViewController.h"
#import "TK1ImageView.h"
#import "UIColor+16.h"
#import "DYScrollRulerView.h"
#import "WatermarkContent1ViewController.h"
#import "CupView.h"
#import "UIImage+Extension.h"
#import "OutputSeting1ViewController.h"
#import "PhotoShowViewController.h"
#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
//#define CROP_PROPORTION_IMAGE_WIDTH 30.0f
//#define CROP_PROPORTION_IMAGE_SPACE 48.0f
//#define CROP_PROPORTION_IMAGE_PADDING 20.0f

//#define MaxSCale 2.0  //最大缩放比例
#define MinScale 50  //最小缩放比例

@interface ClipViewController ()<UIGestureRecognizerDelegate>
{
    CGRect _waterMarkViewRect;
}

@property(nonatomic,strong)UIRotationGestureRecognizer *rotaitonGest;//旋转手势
@property(nonatomic,strong)UIPinchGestureRecognizer *pinchGest;//捏合手势
@property(nonatomic,strong)UIPanGestureRecognizer *panGest;//拖拽手势

@property (nonatomic,strong) UIImage *midImage;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *backImageButton;//返回原图
//控制图片处理的view
@property (nonatomic , strong) UIPanGestureRecognizer *panGes;//拖动
@property (nonatomic , strong) UIPinchGestureRecognizer *pinchGes;//缩放
@property (nonatomic , strong) UIRotationGestureRecognizer *rotationGes;//转转

@end

@implementation ClipViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCropProportionView];
    [self createdTool];
    self.title = @"图片处理";
    [self rightButtonImage:nil RightButtonTitle:@"下一步" rightButtonTarget:self rightButtonAction:@selector(clip:)];
    
    PhotoShowViewController *vc = [[PhotoShowViewController alloc]init];
    vc.selectBlock = ^(NSMutableArray *imageArr) {
        for (UIImage *result in imageArr) {
            self.image = result;
            _imageView.image = result;
        }
        [Tools showGessTipView];
    };
    [self.navigationController pushViewController:vc animated:NO];

    
//    WeakSelf;
//    self.backCall = ^{
//
//        //  [MobClick event:@"album_single_remove_photo"];//[相册单面 删除照片]
//        weakSelf.imageView.image = nil;
//        [weakSelf.navigationController popViewControllerAnimated:YES];
//
//    };
    
}


- (void)createdTool
{
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectZero];
    backGroundView.backgroundColor = [UIColor whiteColor];
    backGroundView.clipsToBounds = YES;
    self.rotationGes = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewRotationAction:)];
    self.rotationGes.delegate = self;
    [backGroundView addGestureRecognizer:self.rotationGes];
    
    self.pinchGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewPinchAction:)];
    self.pinchGes.delegate =self;
    [backGroundView addGestureRecognizer:self.pinchGes];
    
    self.panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewPanAction:)];
    [self.panGes setMinimumNumberOfTouches:1];
    [self.panGes setMaximumNumberOfTouches:1];
    self.panGes.delegate = self;
    [backGroundView addGestureRecognizer:self.panGes];
 
    [self.pinchGes setEnabled:YES];
    [self.rotationGes setEnabled:YES];
    [self.view insertSubview:backGroundView atIndex:0];
    self.backGroundView = backGroundView;
    [self.view addSubview:backGroundView];
    
    [_backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.mas_equalTo(self.view).mas_offset(0);
        make.bottom.mas_equalTo(_bottomView.mas_top).mas_offset(0);
        
    }];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
//    _imageView.image = _image;
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_backGroundView addSubview:_imageView];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.left.right.mas_equalTo(_backGroundView).mas_offset(0);
        
    }];
    
}
/*
 *  创建恢复原图按钮
 */
-(UIButton*)backImageButton{
    
    if (_backImageButton==nil) {
        _backImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backImageButton.frame = CGRectMake(kScreenWidth-80, 10, 60, 30);
        _backImageButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_backImageButton setTitle:@"原图" forState:UIControlStateNormal];
        [_backImageButton setBackgroundImage:[UIImage imageNamed:@"原图按钮"] forState:UIControlStateNormal];
        [_backImageButton addTarget:self action:@selector(returnBackImage) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backImageButton];
    }
    return _backImageButton;
}

/*
 *  恢复原图
 */
-(void)returnBackImage{
    _backImageButton.hidden = YES;
    _imageView.transform = CGAffineTransformIdentity;
    _imageView.frame = _backGroundView.bounds;
}

/**
 *  多个手势同时存在的代理,不能忘记
 */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    if (([gestureRecognizer isEqual:_pinchGest]&&[otherGestureRecognizer isEqual:_panGest])||([gestureRecognizer isEqual:_panGest]&&[otherGestureRecognizer isEqual:_pinchGest])) {
//        NSLog(@"拖动和捏合");
//        return NO;
//    }
//    if (([gestureRecognizer isEqual:_rotaitonGest]&&[otherGestureRecognizer isEqual:_panGest])||([gestureRecognizer isEqual:_panGest]&&[otherGestureRecognizer isEqual:_rotaitonGest])) {
//        NSLog(@"拖动和旋转");
//        return NO;
//    }
//    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]]) {
//        return YES;
//    }else if ([gestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]){
//        return YES;
//    }else{
//        return NO;
//    }
//
//    return YES;
    
//    if (([gestureRecognizer isEqual:_rotaitonGest]&&[otherGestureRecognizer isEqual:_pinchGest])||([gestureRecognizer isEqual:_pinchGest]&&[otherGestureRecognizer isEqual:_rotaitonGest])) {
//        NSLog(@"拖动和旋转");
//        return YES;
//    }
//    if (([gestureRecognizer isEqual:_rotationGes]&&[otherGestureRecognizer isEqual:_pinchGes])||([gestureRecognizer isEqual:_pinchGes]&&[otherGestureRecognizer isEqual:_rotationGes])) {
//        NSLog(@"拖动和旋转");
//        return YES;
//    }
    
    return YES;

}



//下一步按钮事件
- (void)clip:(UIButton *)btn{
    
    //  [MobClick event:@"album_single_next"];//[相册单面 下一步]
    NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:kWaterMarkModel];
    
    WaterMarkMode*model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    
    model.waterMarkPoint = [NSValue valueWithCGPoint:_waterMarkViewRect.origin];
    
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kWaterMarkModel];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
//    [self.waterMarkVeiw setHidden:YES];
    UIImage *image = [Tools imageFromView:self.backGroundView];
    image = [Tools imageFromImage:image atFrame:self.backGroundView.frame];
//    [self.waterMarkVeiw setHidden:NO];
    WatermarkContent1ViewController * vc = [[WatermarkContent1ViewController alloc]init];
    vc.headerImage = image;
    
//    if (!self.waterMarkVeiw.isHidden) {
//        vc.hasWaterMark = YES;
//    }else{
//        vc.hasWaterMark = NO;
//    }
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)setUpCropProportionView {

    _bottomView = [[UIView alloc]initWithFrame:CGRectZero];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        make.height.mas_offset(50);
        make.bottom.mas_equalTo(IOS11_OR_LATER?self.view.mas_safeAreaLayoutGuideBottom:self.view.mas_bottom).mas_offset(0);
        
    }];
    
    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, dealBackView.frame.size.width-20, dealBackView.frame.size.height)];
//    imageView.image = [UIImage imageNamed:@"Rectangle"];
//    imageView.userInteractionEnabled = YES;
//    [_bottomView addSubview:imageView];

    
    UIButton *setMarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setMarkBtn.frame = CGRectMake(10, 7, 100, 30);
    setMarkBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [setMarkBtn setImage:[UIImage imageNamed:@"xiangce"] forState:UIControlStateNormal];
    [setMarkBtn setTitle:@"相册" forState:UIControlStateNormal];
    [setMarkBtn setTitleColor:[UIColor colorWithHexString:@"a0a0a2"] forState:UIControlStateNormal];
    setMarkBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [setMarkBtn addTarget:self action:@selector(handleImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:setMarkBtn];

}

-(void)handleImageAction:(UIButton*)sender{
    
    PhotoShowViewController *vc = [[PhotoShowViewController alloc]init];
    vc.isNomalPush = YES;
    vc.selectBlock = ^(NSMutableArray *imageArr) {
        
        for (UIImage *result in imageArr) {
            _backImageButton.hidden = YES;
            _imageView.image = result;
            _imageView.contentMode = UIViewContentModeScaleAspectFit;
            _imageView.transform = CGAffineTransformIdentity;
        }
        
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark 手势触发事件
//拖动手势
-(void)backGroundViewPanAction:(UIPanGestureRecognizer *)gesture{
    
    if (gesture.numberOfTouches == 1) {
        if (gesture.state == UIGestureRecognizerStateBegan) {
            self.backImageButton.hidden = NO;
            //  [MobClick event:@"album_single_move_photo" attributes:@{@"相册单面移动照片":@"拖动"}];//[相册单面 移动照片]
        }
        if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
            CGPoint transLation = [gesture translationInView:self.backGroundView];
            self.imageView.center = CGPointMake(self.imageView.center.x + transLation.x, self.imageView.center.y + transLation.y);
            [gesture setTranslation:CGPointZero inView:self.backGroundView];
        }
    }
    
}
//缩放手势
-(void)backGroundViewPinchAction:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    //缩小情况
//    if (pinchGestureRecognizer.scale < 1.0) {
//        if (self.pinAngle < MinScale) return;
//    }
    
    if (pinchGestureRecognizer.numberOfTouches<2) {
        return;
    }
    CGPoint onoPoint = [pinchGestureRecognizer locationOfTouch:0 inView:self.view];
    CGPoint twoPoint = [pinchGestureRecognizer locationOfTouch:1 inView:self.view];
    UIView *view = self.imageView;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.backImageButton.hidden = NO;

        //  [MobClick event:@"album_single_move_photo" attributes:@{@"相册单面移动照片":@"放大缩小"}];
    }
        NSLog(@"坐标是%@",NSStringFromCGPoint(onoPoint));
        NSLog(@"坐标是%@",NSStringFromCGPoint(twoPoint));
        
        onoPoint =  [self.view convertPoint:onoPoint toView:view];
        twoPoint =  [self.view convertPoint:twoPoint toView:view];
        NSLog(@"转换后坐标是%@",NSStringFromCGPoint(onoPoint));
        NSLog(@"转换后坐标是%@",NSStringFromCGPoint(twoPoint));
        
        CGPoint anchorPoint;
        anchorPoint.x = (onoPoint.x + twoPoint.x) / 2 / view.bounds.size.width;
        anchorPoint.y = (onoPoint.y + twoPoint.y) / 2 / view.bounds.size.height;
        NSLog(@"放大缩小的锚点是%@",NSStringFromCGPoint(anchorPoint));
        [Tools setAnchorPoint:anchorPoint forView:view];
//    }
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateFailed||pinchGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [Tools setDefaultAnchorPointforView:view];
    }
    
    NSLog(@"%f",pinchGestureRecognizer.scale);
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        
//        self.pinAngle = self.pinAngle * pinchGestureRecognizer.scale;
//        if (self.pinAngle >= 1000) {
//            self.pinAngle = 1000;
//        }
        pinchGestureRecognizer.scale = 1;

    }
}


//旋转手势
-(void)backGroundViewRotationAction:(UIRotationGestureRecognizer *)gesture{
    
    //旋转角度.也是一个累加过程
    if (gesture.numberOfTouches<2) {
        return;
    }
    CGPoint onoPoint = [gesture locationOfTouch:0 inView:gesture.view];
    CGPoint twoPoint = [gesture locationOfTouch:1 inView:gesture.view];
    UIView *view = self.imageView;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.backImageButton.hidden = NO;
        //  [MobClick event:@"album_single_move_photo" attributes:@{@"相册单面移动照片":@"旋转"}];
    }
        NSLog(@"坐标是%@",NSStringFromCGPoint(onoPoint));
        NSLog(@"坐标是%@",NSStringFromCGPoint(twoPoint));
        CGPoint anchorPoints;
        anchorPoints.x = (onoPoint.x + twoPoint.x) / 2 / view.bounds.size.width;
        anchorPoints.y = (onoPoint.y + twoPoint.y) / 2 / view.bounds.size.height;
        NSLog(@"转换前的锚点是%@",NSStringFromCGPoint(anchorPoints));
        
        onoPoint =  [self.view convertPoint:onoPoint toView:view];
        twoPoint =  [self.view convertPoint:twoPoint toView:view];
        NSLog(@"转换后坐标是%@",NSStringFromCGPoint(onoPoint));
        NSLog(@"转换后坐标是%@",NSStringFromCGPoint(twoPoint));
        
        
        CGPoint anchorPoint;
        anchorPoint.x = (onoPoint.x + twoPoint.x) / 2 / view.bounds.size.width;
        anchorPoint.y = (onoPoint.y + twoPoint.y) / 2 / view.bounds.size.height;
        NSLog(@"旋转的锚点是%@",NSStringFromCGPoint(anchorPoint));
        
        [Tools setAnchorPoint:anchorPoint forView:view];
//    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, gesture.rotation);
        [gesture setRotation:0];
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded||gesture.state == UIGestureRecognizerStateFailed) {
        
        [Tools setDefaultAnchorPointforView:view];
    }
}

@end

