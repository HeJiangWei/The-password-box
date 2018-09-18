//
//  OnePickOfTakePhotoController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OnePickOfTakePhotoController.h"
#import <AVFoundation/AVFoundation.h>
#import "CupView.h"
#import "WatermarkContent1ViewController.h"
#import <UIView+Toast.h>
#import "PopGessture1Tip.h"
@interface OnePickOfTakePhotoController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,strong)UIImageView *showImageView;
@property(nonatomic,strong)UIImageView *waterMarkVeiw;//显示水印预览层

@property(nonatomic,strong)CupView *maskView;

@property(nonatomic,strong)UIView *bottomView;

@property(nonatomic,strong)UIButton *takephotoBtn;//拍照按钮
@property(nonatomic,strong)UIButton *nextBtn;//下一步按钮
@property(nonatomic,strong)UIImageView *focusView;//聚焦图片


//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property (nonatomic, strong) AVCaptureDevice *device;

//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property (nonatomic, strong) AVCaptureDeviceInput *input;

//输出图片
@property (nonatomic ,strong) AVCaptureStillImageOutput *imageOutput;

//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property (nonatomic, strong) AVCaptureSession *session;

//图像预览层，实时显示捕获的图像
@property (nonatomic ,strong) AVCaptureVideoPreviewLayer *previewLayer;

@property(nonatomic,assign)BOOL isTakePhoto;//是否拍照

@end

@implementation OnePickOfTakePhotoController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!_isTakePhoto) {
        [self.session startRunning];
    }
    if (_waterMarkVeiw!=nil) {
        NSLog(@"size=%@",NSStringFromCGSize(_waterMarkVeiw.frame.size));
        _waterMarkVeiw.image = [UIImage waterMarkImageSize:_waterMarkVeiw.frame.size];
    }

}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if (self.session.isRunning) {
        [self.session stopRunning];
    }
    
    
}

-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    
    [self initView:self.view.safeAreaInsets];
    
    //初始化界面处理
    [self prepareCapture];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"证件单面";
    [self rightButtonImage:nil RightButtonTitle:@"下一步" rightButtonTarget:self rightButtonAction:@selector(nextAction)];
    if (IOS11_OR_LATER) {
        
    }
    else{
        
        [self initView:UIEdgeInsetsZero];
        
        //初始化界面处理
        [self prepareCapture];
        
    }
    
    WeakSelf;
    
    self.backCall = ^{
        
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        
    };
    
}


/*
 *  增加layer
 */
-(void)addPreviewlayer{
    
    //预览层的生成
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = _bgView.bounds;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [_bgView.layer addSublayer:self.previewLayer];
    
}

/*
 *  初始化界面处理
 */
-(void)prepareCapture{
    
    self.device = [self cameraWithPosition:AVCaptureDevicePositionBack];
    self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    
    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
    //输出设置。AVVideoCodecJPEG   输出jpeg格式图片
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.imageOutput setOutputSettings:outputSettings];
    
    self.session = [[AVCaptureSession alloc] init];
    //     拿到的图像的大小可以自行设定
    //    AVCaptureSessionPreset320x240
    //    AVCaptureSessionPreset352x288
    //    AVCaptureSessionPreset640x480
    //    AVCaptureSessionPreset960x540
    //    AVCaptureSessionPreset1280x720
    //    AVCaptureSessionPreset1920x1080
    //    AVCaptureSessionPreset3840x2160
    
    self.session.sessionPreset = AVCaptureSessionPresetInputPriority;
    //输入输出设备结合
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.imageOutput]) {
        [self.session addOutput:self.imageOutput];
    }
    [self.session startRunning];
    [self addPreviewlayer];
    
    if ([_device lockForConfiguration:nil]) {
        //自动闪光灯，
        if ([_device isFlashModeSupported:AVCaptureFlashModeAuto]) {
            [_device setFlashMode:AVCaptureFlashModeAuto];
        }
        //自动白平衡,但是好像一直都进不去
        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        [_device unlockForConfiguration];
    }
    [self resetFocusAndExposureModes];
}

//自动聚焦、曝光
- (BOOL)resetFocusAndExposureModes{
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureExposureMode exposureMode = AVCaptureExposureModeContinuousAutoExposure;
    AVCaptureFocusMode focusMode = AVCaptureFocusModeContinuousAutoFocus;
    BOOL canResetFocus = [device isFocusPointOfInterestSupported] && [device isFocusModeSupported:focusMode];
    BOOL canResetExposure = [device isExposurePointOfInterestSupported] && [device isExposureModeSupported:exposureMode];
    CGPoint centerPoint = CGPointMake(0.5f, 0.5f);
    NSError *error;
    if ([device lockForConfiguration:&error]) {
        if (canResetFocus) {
            device.focusMode = focusMode;
            device.focusPointOfInterest = centerPoint;
        }
        if (canResetExposure) {
            device.exposureMode = exposureMode;
            device.exposurePointOfInterest = centerPoint;
        }
        [device unlockForConfiguration];
        return YES;
    }
    else{
        NSLog(@"%@", error);
        return NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_isTakePhoto) {
        return;
    }
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:_bgView];
    if (CGRectContainsPoint(_maskView.WillCupRect, point)) {
        if (_focusView) {
            [_focusView removeFromSuperview];
        }
        _focusView = [[UIImageView alloc]initWithFrame:CGRectMake(point.x, point.y, 0, 0)];
        _focusView.image = [UIImage imageNamed:@"focus"];
        [self.view addSubview:_focusView];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            _focusView.frame =CGRectMake(point.x-20, point.y-20, 80, 80);
            
        } completion:^(BOOL finished) {
            
            _focusView.frame =CGRectMake(point.x-17, point.y-17, 61, 62);
            
            
        }];
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            if (_focusView) {
                [_focusView removeFromSuperview];
            }
        });
        
        CGPoint fixpoint = [_previewLayer captureDevicePointOfInterestForPoint:point];
        
        [self focusAtPoint:fixpoint];
    }
}

//聚焦
- (void)focusAtPoint:(CGPoint)point {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([self cameraSupportsTapToFocus] && [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.focusPointOfInterest = point;
            device.focusMode = AVCaptureFocusModeAutoFocus;
            [device unlockForConfiguration];
        }
        else{
            NSLog(@"%@", error);
            
        }
    }
}

- (BOOL)cameraSupportsTapToFocus {
    return [[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo] isFocusPointOfInterestSupported];
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ){
            return device;
        }
    return nil;
}

/*
 *  初始化界面
 */
-(void)initView:(UIEdgeInsets)inset{
    
    _bgView= [[UIView alloc]initWithFrame:self.view.bounds];
    _bgView.userInteractionEnabled = NO;
    [self.view addSubview:_bgView];
    _bgView.clipsToBounds = YES;
    _showImageView = [[UIImageView alloc]initWithFrame:_bgView.bounds];
    [_bgView addSubview:_showImageView];
    
    _maskView = [[CupView alloc]initWithFrame:_bgView.frame inset:inset];
    [self.view addSubview:_maskView];
    
    CGFloat bottomSpace = inset.bottom;
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-80-bottomSpace, kScreenWidth, 80)];
    _bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bottomView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, _bottomView.frame.size.width-20, _bottomView.frame.size.height)];
    imageView.image = [UIImage imageNamed:@"Rectangle"];
    imageView.userInteractionEnabled = YES;
    [_bottomView addSubview:imageView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(14, 13, 40, 54);
    //    [leftBtn setImage:[UIImage imageNamed:@"竖框"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:leftBtn];
    
    _takephotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _takephotoBtn.frame = CGRectMake((imageView.frame.size.width-60)/2.0, 9, 60, 60);
    [_takephotoBtn setImage:[UIImage imageNamed:@"照相机"] forState:UIControlStateNormal];
    [_takephotoBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateSelected];
    
    [_takephotoBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:_takephotoBtn];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(imageView.frame.size.width-63, 13, 40, 54);
    [_nextBtn setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
    [_nextBtn setImage:[UIImage imageNamed:@"8"] forState:UIControlStateSelected];
    
    [_nextBtn addTarget:self action:@selector(clearWaterMark:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:_nextBtn];
    
    //下面的代码默认开启水印
    _nextBtn.selected = YES;
    _waterMarkVeiw = [[UIImageView alloc]initWithFrame:_maskView.WillCupRect];
    CGSize size = CGSizeMake(_waterMarkVeiw.frame.size.width, _waterMarkVeiw.frame.size.height);
    _waterMarkVeiw.image = [UIImage waterMarkImageSize:size];
    
    [self.view addSubview:_waterMarkVeiw];

    
    //旋转
    UIRotationGestureRecognizer *rotaitonGest = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationView:)];
    rotaitonGest.delegate =self;
    [_bgView addGestureRecognizer:rotaitonGest];
    
    //捏合
    UIPinchGestureRecognizer *pinchGest = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinView:)];
    [_bgView addGestureRecognizer:pinchGest];
    
    //拖拽
    UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pangessaction:)];
    [_bgView addGestureRecognizer:panGest];
    _bgView.userInteractionEnabled = NO;
    
}

/*
 *  拖动手势
 */
-(void)pangessaction:(UIPanGestureRecognizer*)panGest{
    if (panGest.state == UIGestureRecognizerStateBegan || panGest.state == UIGestureRecognizerStateChanged) {
        CGPoint trans = [panGest translationInView:panGest.view];
        NSLog(@"%@",NSStringFromCGPoint(trans));
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            if (IOS11_OR_LATER) {
                [Tools showAleartView:self.view.safeAreaInsets];
                
            }
            else{
                [Tools showAleartView:UIEdgeInsetsZero];
                
            }
        });
        
        //设置图片移动
        CGPoint center =  _showImageView.center;
        center.x += trans.x;
        center.y += trans.y;
        _showImageView.center = center;
        
        //清除累加的距离
        [panGest setTranslation:CGPointZero inView:panGest.view];
    }
    
}

-(void)pinView:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    UIView *view = _showImageView;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        //        if (_imageView.frame.size.width < oldFrame.size.width) {
        //            _imageView.frame = oldFrame;
        //            //让图片无法缩得比原图小
        //        }
        //        if (_imageView.frame.size.width > 3 * oldFrame.size.width) {
        //            _imageView.frame = largeFrame;
        //        }
        pinchGestureRecognizer.scale = 1;
    }
    
}

-(void)rotationView:(UIRotationGestureRecognizer *)rotationGestureRecognizer{
    //旋转角度.也是一个累加过程
    NSLog(@"%f",rotationGestureRecognizer.rotation);
    UIView *view = _showImageView;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

/**
 *  多个手势同时存在的代理,不能忘记
 */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}


/*
 *  拍照或者删除
 */
-(void)takePhoto{
    
    _takephotoBtn.selected =!_takephotoBtn.selected;
    
    if (_takephotoBtn.selected) {
        AVCaptureConnection *conntion = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
        if (!conntion) {
            NSLog(@"拍照失败!");
            return;
        }
        //        [conntion setVideoScaleAndCropFactor:1];
        [self.imageOutput captureStillImageAsynchronouslyFromConnection:conntion completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            if (imageDataSampleBuffer == nil) {
                return ;
            }
            [self.session stopRunning];
            [self.previewLayer removeFromSuperlayer];
            
            _bgView.userInteractionEnabled = YES;
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [UIImage imageWithData:imageData];
            _showImageView.image = image;
            
            //            [_nextBtn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            _isTakePhoto = YES;
            
            [Tools showGessTipView];
//            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7.0/*延迟执行时间*/ * NSEC_PER_SEC));
//            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//                [Tools showAleartView];
//            });

        }];
        
    }
    else{
        //        [_nextBtn setImage:[UIImage imageNamed:@"下一步"] forState:UIControlStateNormal];
        _isTakePhoto = NO;
        _bgView.userInteractionEnabled = NO;
        
        _showImageView.image = nil;
        _showImageView.transform = CGAffineTransformIdentity;
        _showImageView.contentMode = UIViewContentModeScaleAspectFill;
        _showImageView.frame = self.view.bounds;
        
        [self addPreviewlayer];
        [self.session startRunning];
    }
    
}

/*
 *  左边的按钮事件
 */
-(void)leftAction:(UIButton*)btn{
    
    [self.navigationController popViewControllerAnimated:NO];
    
    
    //    UIEdgeInsets inset = UIEdgeInsetsZero;
    //
    //    btn.selected = !btn.selected;
    //    if (btn.selected) {
    //        //竖框
    //        CGFloat top = 64;
    //        if (IOS11_OR_LATER) {
    //            inset =  self.view.safeAreaInsets;
    //            top = inset.top;
    //        }
    //
    //        CGFloat height = kScreenHeight - inset.bottom-_bottomView.bounds.size.height-top - 40;
    //        CGFloat width = height*210/297.0;
    //        if (width>=kScreenWidth) {
    //            width = kScreenWidth-40;
    //            height = 297*width/210.0;
    //
    //        }
    //        _maskView.WillCupRect = CGRectMake((kScreenWidth-width)/2.0, top+(kScreenHeight-top-80-inset.bottom-height)/2.0, width, height);
    //    }
    //    else{
    //        //横框
    //        CGFloat width = kScreenWidth-40;
    //        CGFloat height = width*54/85.6;
    //        CGFloat top = 0;
    //        CGFloat bottom =0;
    //        if (inset.top==0) {
    //            top = 64;
    //        }
    //        else{
    //            top = inset.top;
    //        }
    //        bottom = inset.bottom;
    //        _maskView.WillCupRect = CGRectMake(20, top+(kScreenHeight-height-bottom-top-80)/2.0, width, height);
    //
    //    }
    //    [_maskView setNeedsDisplay];
    
}


/*
 *  添加水印
 */
-(void)clearWaterMark:(UIButton*)btn{
    
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        //        if (_waterMarkVeiw==nil) {
        _waterMarkVeiw = [[UIImageView alloc]initWithFrame:_maskView.WillCupRect];
        CGSize size = CGSizeMake(_waterMarkVeiw.frame.size.width, _waterMarkVeiw.frame.size.height);
        _waterMarkVeiw.image = [UIImage waterMarkImageSize:size];
        
        [self.view addSubview:_waterMarkVeiw];
        //        }
    }
    else{
        [_waterMarkVeiw removeFromSuperview];
    }
    
}

/*
 *  下一步按钮事件
 */
-(void)nextAction{
    
    if (!_isTakePhoto) {
        [self.view makeToast:@"请先拍照"];
        return;
    }
    
    //获取图片bgview视图上的图片
    UIImage *image = [Tools imageFromView:_bgView];
    
    image = [Tools imageFromImage:image atFrame:_maskView.WillCupRect];
    WatermarkContent1ViewController *vc = [[WatermarkContent1ViewController alloc]init];
    vc.headerImage  = image;
    //    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

