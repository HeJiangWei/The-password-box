//
//  DoubleImageOfTakePhotoController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DoubleImageOfTakePhotoController.h"
#import "ImageShowView.h"
#import "CupTwoView.h"
#import "WatermarkContent1ViewController.h"
#import "OutputSeting1ViewController.h"
#import "OnePickOfTakePhotoController.h"
#import <AVFoundation/AVFoundation.h>
#import <UIView+Toast.h>
#import "PopGessture1Tip.h"
#import "EnlargeButton.h"
#import "WaterMarkMode.h"
@interface DoubleImageOfTakePhotoController ()<UIGestureRecognizerDelegate,UIAlertViewDelegate>
{
    CGFloat _spaceWithCutRect;
    CGRect _waterMarkViewRect;
    
}

@property(nonatomic,strong)UIRotationGestureRecognizer *rotaitonGest;//旋转手势
@property(nonatomic,strong)UIPinchGestureRecognizer *pinchGest;//捏合手势
@property(nonatomic,strong)UIPanGestureRecognizer *panGest;//拖拽手势

@property(nonatomic,strong)UIView *bgView;//背景装载视图
@property(nonatomic,strong)UIImageView *largeImageView;//显示最大的图片
@property(nonatomic,strong)UIView *waterMarkVeiw;//装水印
@property(nonatomic,strong)UIImageView *waterMarkImageVeiw;//显示水印
@property (nonatomic,strong) UIActivityIndicatorView *actiview;//显示正在初始化相机

@property(nonatomic,strong)EnlargeButton* deleteTopButton;//删除按钮
@property(nonatomic,strong)EnlargeButton* deleteSecondButton;//删除按钮

@property(nonatomic,strong)UIView* showTopTakePhotoView;//拍照正面
@property(nonatomic,strong)UIView* showSecondTakePhotoView;//拍照反面

@property(nonatomic,strong)CupTwoView *maskView;//蒙版显示层
@property(nonatomic,strong)UIImageView *focusView;//聚焦图片

@property(nonatomic,strong)UIButton *takephotoBtn;//拍照按钮
@property(nonatomic,strong)UIButton *nextBtn;//下一步按钮

@property(nonatomic,strong)UIView *bottomView;//下一步视图

@property(nonnull,strong)UIView *showTipView;//显示的视图
@property(nonnull,strong)UIView *showSecondTipView;//显示的视图

@property(nonatomic,strong)ImageShowView *currentSelectImageView;//当前选中的内容视图
@property(nonatomic,assign)BOOL isTopArea;//是否点击的是上面的那个

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

@end

@implementation DoubleImageOfTakePhotoController


-(void)viewWillAppear:(BOOL)animated{
    
    if (_maskView.shwoView2.isSetImage&&_maskView.shwoView.isSetImage) {
        
    }
    else{
        if (self.session) {
            [self.session startRunning];
        }
    }
    if (_waterMarkVeiw!=nil) {
        NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:kWaterMarkModel];
        
        WaterMarkMode*model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
        
        CGPoint point = model.doublePhotoWaterMarkPoint.CGPointValue;
        CGRect rect = _waterMarkImageVeiw.frame;
        rect.origin = point;
        
        _waterMarkImageVeiw.image = [UIImage waterMarkImageSize:CGSizeMake(_waterMarkVeiw.frame.size.width*kwaterMarkFrameMultiple, _waterMarkVeiw.frame.size.height*kwaterMarkFrameMultiple)];
        _waterMarkImageVeiw.frame = rect;
        _waterMarkViewRect = _waterMarkImageVeiw.frame;
        
    }
    
    //    [super viewWillAppear:animated];
    //
    //    if (_topShowView.isSetImage&&_secondShowView.isSetImage == NO) {
    //        _isSecondPrepare = YES;
    //        _isTopPrepare = NO;
    //        _currentSelectImageView = _secondShowView;
    //        _topShowView.layer.borderColor = [UIColor colorWithHexString:@"#0373F6"].CGColor;
    //        _secondShowView.layer.borderColor = [UIColor redColor].CGColor;
    //
    //        [self startWithFrame:_secondShowView.bounds andInView:_secondShowView];
    //    }
    //    else if(_secondShowView.isSetImage&&_topShowView.isSetImage == NO){
    //        _isSecondPrepare = NO;
    //        _isTopPrepare = YES;
    //        _currentSelectImageView = _topShowView;
    //        _secondShowView.layer.borderColor = [UIColor colorWithHexString:@"#0373F6"].CGColor;
    //        _topShowView.layer.borderColor = [UIColor redColor].CGColor;
    //
    //        [self startWithFrame:_topShowView.bounds andInView:_topShowView];
    //    }
    //    else if(_topShowView.isSetImage&&_secondShowView.isSetImage){
    //
    //    }
    //    else{
    //        _currentSelectImageView = _topShowView;
    //        _isTopPrepare = YES;
    //        _isSecondPrepare = NO;
    //        _secondShowView.layer.borderColor = [UIColor colorWithHexString:@"#0373F6"].CGColor;
    //        _topShowView.layer.borderColor = [UIColor redColor].CGColor;
    //
    //        [self startWithFrame:_topShowView.bounds andInView:_topShowView];
    //    }
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if (self.session.isRunning) {
        [self.session stopRunning];
    }
}

//这个方法只会ios11以上的系统才会调用
-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    NSLog(@"调用了");
    [self initView:self.view.safeAreaInsets];
    //初始化界面处理
    [self prepareCapture];
    
    [Tools acquireMediaType:AVMediaTypeVideo Auth:^(BOOL grant){
        [_actiview stopAnimating];
        [_actiview removeFromSuperview];
        if (grant) {
            [self.session startRunning];
            [self resetFocusAndExposureModes];
            [self showFocusKuang:_maskView.shwoView.center];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"获取授权" message:@"您已设置关闭使用相机,请在设备的设置-隐私-相机中允许使用。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定" ,nil];
            [alert show];
        }
    }];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"双面拍照";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#4A4A4A"];
    
    if (IOS11_OR_LATER) {
        
    }
    else{
        [self initView:UIEdgeInsetsZero];
        
        //初始化界面处理
        [self prepareCapture];
        
        [Tools acquireMediaType:AVMediaTypeVideo Auth:^(BOOL grant){
            [_actiview stopAnimating];
            [_actiview removeFromSuperview];
            if (grant) {
                [self.session startRunning];
                [self resetFocusAndExposureModes];
                [self showFocusKuang:_maskView.shwoView.center];

            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"获取授权" message:@"您已设置关闭使用相机,请在设备的设置-隐私-相机中允许使用。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定" ,nil];
                [alert show];
            }
        }];
        
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if (IOS10_OR_LATER) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
        else{
            [[UIApplication sharedApplication] openURL:url];
        }
    }
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
    
    //预览层的生成
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = _bgView.bounds;
    [_bgView.layer addSublayer:self.previewLayer];
    
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
    NSLog(@"我在触摸");
    if (![self.session isRunning]) {
        return;
    }
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:_bgView];
    if (CGRectContainsPoint(_maskView.WillCupRect, point)||CGRectContainsPoint(_maskView.WillCupRect2, point)) {
        
        if (CGRectContainsPoint(_maskView.WillCupRect, point)&&_maskView.shwoView.isSetImage) {
            return;
        }
        if (CGRectContainsPoint(_maskView.WillCupRect2, point)&&_maskView.shwoView2.isSetImage) {
            return;
        }
        
        [self showFocusKuang:point];
        
        //在点击的范围内,才可以聚焦
        [self focusAtPoint:point];
    }
    
}

/*
 *  显示聚焦框
 */
-(void)showFocusKuang:(CGPoint)point{
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

}
//聚焦
- (void)focusAtPoint:(CGPoint)point {
    
    point = [_previewLayer captureDevicePointOfInterestForPoint:point];

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

- (AVCaptureVideoOrientation)avOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation
{
    AVCaptureVideoOrientation result = (AVCaptureVideoOrientation)deviceOrientation;
    if ( deviceOrientation == UIDeviceOrientationLandscapeLeft )
        result = AVCaptureVideoOrientationLandscapeRight;
    else if ( deviceOrientation == UIDeviceOrientationLandscapeRight)
        result = AVCaptureVideoOrientationLandscapeLeft;
    return result;
}

/*
 *   初始化界面
 */
-(void)initView:(UIEdgeInsets)inset{
    
    _bgView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_bgView];
    _largeImageView = [[UIImageView alloc]initWithFrame:_bgView.bounds];
    _largeImageView.contentMode = UIViewContentModeScaleAspectFill;
    _largeImageView.backgroundColor = [UIColor clearColor];
    _largeImageView.userInteractionEnabled = YES;
    [_bgView addSubview:_largeImageView];
    
    _maskView = [[CupTwoView alloc]initWithFrame:_bgView.bounds];
    WeakSelf;
    //点击拍照的block
    _maskView.takePhotoBlack = ^(ImageShowView*showView,BOOL first){
        weakSelf.isTopArea = first;
        weakSelf.currentSelectImageView = showView;
        if (weakSelf.currentSelectImageView.isSetImage) {
            weakSelf.takephotoBtn.selected = YES;
        }
        else{
            weakSelf.takephotoBtn.selected = NO;
        }
        if (_maskView.shwoView.isSetImage&&_maskView.shwoView2.isSetImage) {
            NSLog(@"两张都有的情况下");
        }
        else{
            //            if (!weakSelf.maskView.shwoView.isSetImage&&!weakSelf.maskView.shwoView2.isSetImage) {
            //                //如果第二个没有设置图片,那么就吧点击拍照去掉
            ////                [weakSelf.showTopTakePhotoView removeFromSuperview];
            ////                [weakSelf setSecondClickView];
            //            }
            //            else if (!weakSelf.maskView.shwoView2.isSetImage&&!weakSelf.maskView.shwoView.isSetImage) {
            ////                [weakSelf.showSecondTakePhotoView removeFromSuperview];
            ////                [weakSelf setTopClickView];
            //            }
            if (!showView.isSetImage) {
                if (![weakSelf.session isRunning]) {
                    
                    [weakSelf.session startRunning];
                }
            }
        }
    };
    [self.view addSubview:_maskView];
    
    
    _isTopArea = YES;
    _spaceWithCutRect = _maskView.WillCupRect2.origin.y-CGRectGetMaxY(_maskView.WillCupRect);
    //    UIView *maskView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_maskView.WillCupRect), kScreenWidth, _spaceWithCutRect)];
    //    maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    //    [self.view addSubview:maskView];
    //设置显示拍照反面
    [self setSecondClickView];
    
    _currentSelectImageView = _maskView.shwoView;
    CGFloat bottomSpace = inset.bottom;
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-80 - bottomSpace, self.view.bounds.size.width, 80)];
    _bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bottomView];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, _bottomView.frame.size.width-20, _bottomView.frame.size.height)];
    imageView.image = [UIImage imageNamed:@"Rectangle"];
    imageView.userInteractionEnabled = YES;
    [_bottomView addSubview:imageView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(20, 13, 40, 53);
    [leftBtn setImage:[UIImage imageNamed:@"设置水印"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:leftBtn];
    
    _takephotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _takephotoBtn.frame = CGRectMake((imageView.frame.size.width-60)/2.0, 9, 60, 60);
    [_takephotoBtn setImage:[UIImage imageNamed:@"照相机"] forState:UIControlStateNormal];
    //    [_takephotoBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateSelected];
    
    [_takephotoBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:_takephotoBtn];
    
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(imageView.frame.size.width-60, 13, 40, 54);
    [_nextBtn setImage:[UIImage imageNamed:@"水印不可见"] forState:UIControlStateNormal];
    [_nextBtn setImage:[UIImage imageNamed:@"水印可见"] forState:UIControlStateSelected];
    [_nextBtn addTarget:self action:@selector(clearWatermark:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:_nextBtn];
    //下面的代码默认开启水印
    _nextBtn.selected = YES;
    _waterMarkVeiw = [[UIView alloc]initWithFrame:CGRectMake(_maskView.WillCupRect.origin.x, _maskView.WillCupRect.origin.y, _maskView.WillCupRect.size.width, _maskView.WillCupRect.size.height+_maskView.WillCupRect2.size.height+_spaceWithCutRect)];
    
    NSData *lastmodelData = [[NSUserDefaults standardUserDefaults] objectForKey:kWaterMarkModel];
    if (lastmodelData==nil) {
        _waterMarkImageVeiw = [[UIImageView alloc]initWithFrame:CGRectMake(-_waterMarkVeiw.frame.size.width/2.0, -_waterMarkVeiw.frame.size.height/2, kwaterMarkFrameMultiple*_waterMarkVeiw.frame.size.width, kwaterMarkFrameMultiple*_waterMarkVeiw.frame.size.height)];
    }
    else{
        WaterMarkMode *lastModel = [NSKeyedUnarchiver unarchiveObjectWithData:lastmodelData];
        CGPoint point = lastModel.doublePhotoWaterMarkPoint.CGPointValue;
        _waterMarkImageVeiw = [[UIImageView alloc]initWithFrame:CGRectMake(point.x, point.y, kwaterMarkFrameMultiple*_waterMarkVeiw.frame.size.width, kwaterMarkFrameMultiple*_waterMarkVeiw.frame.size.height)];
    }
    _waterMarkImageVeiw.image = [UIImage waterMarkImageSize:CGSizeMake(_waterMarkVeiw.frame.size.width*kwaterMarkFrameMultiple, _waterMarkVeiw.frame.size.height*kwaterMarkFrameMultiple)];
    _waterMarkVeiw.userInteractionEnabled = YES;
    _waterMarkViewRect = _waterMarkImageVeiw.frame;
    _waterMarkVeiw.backgroundColor = [UIColor clearColor];
    [_waterMarkVeiw addSubview:_waterMarkImageVeiw];
    _waterMarkVeiw.clipsToBounds = YES;
    
    [self.view addSubview:_waterMarkVeiw];
    
    [self.view insertSubview:_waterMarkVeiw atIndex:2];
    
    
    //设置相机初始化界面
    _actiview = [[UIActivityIndicatorView alloc]initWithFrame:_bgView.bounds];
    [_actiview startAnimating];
    _actiview.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, (_bgView.bounds.size.height-50)/2+50, _bgView.bounds.size.width, 50)];
    label.text = @"正在初始化相机...";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [_actiview addSubview:label];
    _actiview.backgroundColor = [UIColor lightGrayColor];
    [_bgView addSubview:_actiview];
    
    
    
    
    _panGest = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pangessaction:)];
    _panGest.delegate = self;
    _panGest.maximumNumberOfTouches  = 1;
    _panGest.minimumNumberOfTouches  = 1;
    
    [_waterMarkVeiw addGestureRecognizer:_panGest];
    //旋转
    _rotaitonGest = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationView:)];
    _rotaitonGest.delegate =self;
    [_waterMarkVeiw addGestureRecognizer:_rotaitonGest];
    
    //捏合
    _pinchGest = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinView:)];
    _pinchGest.delegate =self;
    [_waterMarkVeiw addGestureRecognizer:_pinchGest];
    
}

/*
 *  拍照
 */
-(void)takePhoto{
    
    if (_maskView.shwoView2.isSetImage&&_maskView.shwoView.isSetImage) {
        return;
    }
    
    AVCaptureConnection *conntion = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    UIDeviceOrientation curDeviceOrientation = [[UIDevice currentDevice] orientation];
    AVCaptureVideoOrientation avcaptureOrientation = [self avOrientationForDeviceOrientation:curDeviceOrientation];
    [conntion setVideoOrientation:avcaptureOrientation];
    if (!conntion) {
        NSLog(@"拍照失败!");
        return;
    }
    
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:conntion completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        
        if (imageDataSampleBuffer == nil) {
            return ;
        }
        
        [self.session stopRunning];
        
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *newsImage = [UIImage imageWithData:imageData];
        _largeImageView.image = newsImage;
        UIImage * newsImages = [Tools imageFromView:_largeImageView];
        _currentSelectImageView.isSetImage = YES;
        
        _currentSelectImageView.image = newsImages;
        
        _currentSelectImageView.clipsToBounds = YES;
        
        [self addDeleteBtn];
        if (_maskView.shwoView2.isSetImage&&_maskView.shwoView.isSetImage) {
            [self rightButtonImage:nil RightButtonTitle:@"下一步" rightButtonTarget:self rightButtonAction:@selector(nextAction)];
        }
        if (_isTopArea) {
            //  [MobClick event:@"double_take_photo_a"];//[双面 拍照a]
            
            if (!_maskView.shwoView2.isSetImage) {
                //如果下面的没有设置图片,那么自动显示拍照
                _isTopArea = NO;
                [_showSecondTakePhotoView removeFromSuperview];
                _currentSelectImageView = _maskView.shwoView2;
                
                if (![self.session isRunning]) {
                    [self.session startRunning];
                }
                [self showFocusKuang:_maskView.shwoView2.center];
                [self focusAtPoint:_maskView.shwoView2.center];
            }
        }
        else{
            //  [MobClick event:@"double_take_photo_b"];//[双面 拍照b]
            if (!_maskView.shwoView.isSetImage) {
                //如果上面的没有设置图片,那么自动显示拍照
                _isTopArea = YES;
                [_showTopTakePhotoView removeFromSuperview];
                _currentSelectImageView = _maskView.shwoView;
                [self showFocusKuang:_maskView.shwoView.center];

                if (![self.session isRunning]) {
                    [self.session startRunning];
                }
                [self showFocusKuang:_maskView.shwoView2.center];
                [self focusAtPoint:_maskView.shwoView2.center];
            }
        }
        
        
        _largeImageView.image = nil;
        [Tools showGessTipView];
//        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7.0/*延迟执行时间*/ * NSEC_PER_SEC));
//        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//            [Tools showAleartView];
//        });
        
    }];
    
    
}
/*
 *  添加删除按钮在上面
 */
-(void)addDeleteBtn{
    if (_isTopArea) {
        
        _deleteTopButton = [EnlargeButton buttonWithType:UIButtonTypeCustom];
        _deleteTopButton.frame = CGRectMake(CGRectGetMaxX(_maskView.shwoView.frame)-30, _maskView.shwoView.frame.origin.y+5, 24, 24);
        [_deleteTopButton setImage:[UIImage imageNamed:@"重新选择"] forState:UIControlStateNormal];
        _deleteTopButton.tag = 100;
        [_deleteTopButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_deleteTopButton];
    }
    else{
        _deleteSecondButton = [EnlargeButton buttonWithType:UIButtonTypeCustom];
        _deleteSecondButton.frame = CGRectMake(CGRectGetMaxX(_maskView.shwoView2.frame)-30, _maskView.shwoView2.frame.origin.y+5, 24, 24);
        [_deleteSecondButton setImage:[UIImage imageNamed:@"重新选择"] forState:UIControlStateNormal];
        _deleteSecondButton.tag = 101;
        [_deleteSecondButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_deleteSecondButton];
        
    }
}

/*
 * 删除按钮事件
 */
-(void)deleteAction:(UIButton *)btn{
    self.navigationItem.rightBarButtonItem = nil;
    if (btn.tag==100) {
        //  [MobClick event:@"double_remove_photo_a"];//[双面 删除照片a]
        
        _isTopArea = YES;
        [_deleteTopButton removeFromSuperview];
        _currentSelectImageView = _maskView.shwoView;
    }
    else{
        //  [MobClick event:@"double_remove_photo_b"];//[双面 删除照片b]
        _isTopArea = NO;
        [_deleteSecondButton removeFromSuperview];
        _currentSelectImageView = _maskView.shwoView2;
        
        
    }
    if (_isTopArea) {
        //上面,如果下面没有拍照,那么显示拍照的文字
        if (!_maskView.shwoView2.isSetImage) {
            
            [self setSecondClickView];
        }
    }
    else{
        if (!_maskView.shwoView.isSetImage) {
            
            [self setTopClickView];
        }
    }
    
    //    _takephotoBtn.selected = NO;
    
    _maskView.shwoView2.rotaitonGest.enabled = YES;
    _maskView.shwoView2.panGest.enabled = YES;
    _maskView.shwoView2.pinchGest.enabled = YES;
    _maskView.shwoView.rotaitonGest.enabled = YES;
    _maskView.shwoView.panGest.enabled = YES;
    _maskView.shwoView.pinchGest.enabled = YES;
    
    _currentSelectImageView.isSetImage = NO;
    //    [_currentSelectImageView.showLabel removeFromSuperview];
    _currentSelectImageView.image = nil;
    _currentSelectImageView.backgroundColor = [UIColor clearColor];
    [self.session startRunning];
    
    if (_isTopArea) {
        [self showFocusKuang:_maskView.shwoView.center];
        [self focusAtPoint:_maskView.shwoView.center];

    }
    else{
        [self showFocusKuang:_maskView.shwoView2.center];
        [self focusAtPoint:_maskView.shwoView2.center];
    }

    
}

-(void)pinView:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    if (pinchGestureRecognizer.numberOfTouches<2) {
        return;
    }
    CGPoint onoPoint = [pinchGestureRecognizer locationOfTouch:0 inView:self.view];
    CGPoint twoPoint = [pinchGestureRecognizer locationOfTouch:1 inView:self.view];
    UIView *view ;
    
    if (CGRectContainsPoint(_maskView.shwoView.frame, onoPoint)&&CGRectContainsPoint(_maskView.shwoView.frame, twoPoint)) {
        view = _maskView.shwoView.imageView;
    }
    else if(CGRectContainsPoint(_maskView.shwoView2.frame, onoPoint)&&CGRectContainsPoint(_maskView.shwoView2.frame, twoPoint)){
        view = _maskView.shwoView2.imageView;
    }
    else{
        return;
    }
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        if ([view  isEqual:_maskView.shwoView.imageView]) {
            NSLog(@"----------上面上面-----------");
            
            //  [MobClick event:@"double_move_photo_a" attributes:@{@"拍照双面上":@"放大缩小"}];
        }
        else{
            NSLog(@"----------下面下面-----------");
            
            //  [MobClick event:@"double_move_photo_b" attributes:@{@"拍照双面下":@"放大缩小"}];
        }
        
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
        pinchGestureRecognizer.scale = 1;
    }
    
    
}


-(void)rotationView:(UIRotationGestureRecognizer *)rotationGestureRecognizer{
    
    //旋转角度.也是一个累加过程
    if (rotationGestureRecognizer.numberOfTouches<2) {
        return;
    }
    NSLog(@"%f转换成角度%f",rotationGestureRecognizer.rotation,rotationGestureRecognizer.rotation/M_PI*180);
    CGPoint onoPoint = [rotationGestureRecognizer locationOfTouch:0 inView:self.view];
    CGPoint twoPoint = [rotationGestureRecognizer locationOfTouch:1 inView:self.view];
    UIView *view;
    if (CGRectContainsPoint(_maskView.shwoView.frame, onoPoint)&&CGRectContainsPoint(_maskView.shwoView.frame, twoPoint)) {
        view = _maskView.shwoView.imageView;
    }
    else if(CGRectContainsPoint(_maskView.shwoView2.frame, onoPoint)&&CGRectContainsPoint(_maskView.shwoView2.frame, twoPoint)){
        view = _maskView.shwoView2.imageView;

    }
    else{
        return;
    }
    
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        if ([view  isEqual:_maskView.shwoView.imageView]) {
            NSLog(@"----------上面上面-----------");
            
            //  [MobClick event:@"double_move_photo_a" attributes:@{@"拍照双面上":@"旋转"}];
        }
        else{
            NSLog(@"----------下面下面-----------");
            
            //  [MobClick event:@"double_move_photo_b" attributes:@{@"拍照双面下":@"旋转"}];
        }
    
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
    if ( rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
    
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateEnded||rotationGestureRecognizer.state == UIGestureRecognizerStateFailed) {
        [Tools setDefaultAnchorPointforView:view];

    }
    
    
}



/*
 *  拖动手势
 */
-(void)pangessaction:(UIPanGestureRecognizer*)panGest{
    NSLog(@"我在拖动");
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        if (IOS11_OR_LATER) {
            [Tools showAleartView:self.view.safeAreaInsets];
            
        }
        else{
            [Tools showAleartView:UIEdgeInsetsZero];
            
        }
    });
    NSLog(@"水印的frame==%@",NSStringFromCGRect(_waterMarkImageVeiw.frame));
    BOOL isRecorve = YES;
    
    if (panGest.state == UIGestureRecognizerStateBegan) {
        //  [MobClick event:@"double_move_watermark"];//[双面 移动水印]

        CGPoint trans = [panGest translationInView:panGest.view];
        _waterMarkViewRect = _waterMarkImageVeiw.frame;
        //设置图片移动
        CGPoint center =  _waterMarkImageVeiw.center;
        center.x += trans.x;
        center.y += trans.y;
        _waterMarkImageVeiw.center = center;
        NSLog(@"水印的frame==%@",NSStringFromCGRect(_waterMarkImageVeiw.frame));
        //清除累加的距离
        [panGest setTranslation:CGPointZero inView:panGest.view];
    }
    
    if (panGest.state == UIGestureRecognizerStateChanged) {
        CGPoint trans = [panGest translationInView:panGest.view];
        
        //设置图片移动
        CGPoint center =  _waterMarkImageVeiw.center;
        center.x += trans.x;
        center.y += trans.y;
        _waterMarkImageVeiw.center = center;
        _waterMarkViewRect = _waterMarkImageVeiw.frame;
        
        //清除累加的距离
        [panGest setTranslation:CGPointZero inView:panGest.view];
        
        if ((_waterMarkImageVeiw.frame.origin.x>0)) {
            isRecorve = YES;
            _waterMarkViewRect.origin.x = 0;
            NSLog(@"x应该为0");
        }
        if ((_waterMarkImageVeiw.frame.origin.x<-_waterMarkVeiw.frame.size.width*(kwaterMarkFrameMultiple-1))) {
            isRecorve = YES;
            
            _waterMarkViewRect.origin.x = -_waterMarkVeiw.frame.size.width*(kwaterMarkFrameMultiple-1);
            NSLog(@"x应该为_waterMarkVeiw.frame.size.width");
            
        }
        if ((_waterMarkImageVeiw.frame.origin.y<-_waterMarkVeiw.frame.size.height*(kwaterMarkFrameMultiple-1))) {
            isRecorve = YES;
            
            _waterMarkViewRect.origin.y = -_waterMarkVeiw.frame.size.height*(kwaterMarkFrameMultiple-1);
            NSLog(@"y应该为_waterMarkVeiw.frame.size.height");
            
        }
        if ((_waterMarkImageVeiw.frame.origin.y>0)) {
            isRecorve = YES;
            _waterMarkViewRect.origin.y = 0;
            NSLog(@"y应该为0");
        }
    }
    
    if (panGest.state == UIGestureRecognizerStateEnded || panGest.state == UIGestureRecognizerStateFailed) {
        if (isRecorve) {
            
            [UIView animateWithDuration:0.2 animations:^{
                NSLog(@"这个frame%@",NSStringFromCGRect(_waterMarkViewRect));
                _waterMarkImageVeiw.frame = _waterMarkViewRect;
                
            }];
        }
        
    }
    
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
    if (([gestureRecognizer isEqual:_rotaitonGest]&&[otherGestureRecognizer isEqual:_pinchGest])||([gestureRecognizer isEqual:_pinchGest]&&[otherGestureRecognizer isEqual:_rotaitonGest])) {
        NSLog(@"拖动和旋转");
        return YES;
    }

    return NO;
}


/*
 *  添加清除水印
 */
-(void)clearWatermark:(UIButton*)btn{
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        //  [MobClick event:@"double_show_watermark"];//[双面 显示水印]
        _waterMarkVeiw.hidden = NO;
    }
    else{
        //  [MobClick event:@"double_hide_watermark"];//[双面 隐藏水印]
        _waterMarkVeiw.hidden = YES;
    }
    
}

/*
 *  下一步按钮事件
 */
-(void)nextAction{
    
    //  [MobClick event:@"double_next"];//[双面  下一步]
    
    if (_maskView.shwoView.isSetImage&&_maskView.shwoView2.isSetImage) {
        
        NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:kWaterMarkModel];
        
        WaterMarkMode*model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
        model.doublePhotoWaterMarkPoint = [NSValue valueWithCGPoint:_waterMarkViewRect.origin];
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:model];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kWaterMarkModel];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIImage *image = [Tools imageFromView:_maskView.shwoView];
        
        UIImage *images = [Tools imageFromView:_maskView.shwoView2];
        
        UIImage *finallImage = [Tools addImage:image toImage:images andSpace:_spaceWithCutRect];
        
        OutputSeting1ViewController *vc = [[OutputSeting1ViewController alloc]init];
        vc.headerImage = finallImage;
        vc.isDoubleWaterMark = YES;
        vc.hasWaterMark = !_waterMarkVeiw.isHidden;
        [self.navigationController pushViewController:vc animated:true];
        
    }
    else{
        
        [self.navigationController.view makeToast:@"需两张拍照完,才能下一步"];
        
    }
    
}


/*
 *  左边按钮事件
 */
-(void)leftAction{
    
    //  [MobClick event:@"double_setting"];//[双面 设置水印]
    
    NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:kWaterMarkModel];
    
    WaterMarkMode*model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    
    model.doublePhotoWaterMarkPoint = [NSValue valueWithCGPoint:_waterMarkViewRect.origin];
    
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kWaterMarkModel];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIImage *finallImage;
    if (!_maskView.shwoView.isSetImage||!_maskView.shwoView2.isSetImage) {
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_maskView.shwoView.frame.origin.x, _maskView.shwoView.frame.origin.y, _maskView.shwoView.frame.size.width, _maskView.shwoView.frame.size.height+_maskView.shwoView2.frame.size.height+_spaceWithCutRect)];
        bgImageView.backgroundColor = [UIColor whiteColor];
        UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,_maskView.shwoView.frame.size.width, _maskView.shwoView.frame.size.height)];
        topImageView.image = [UIImage imageNamed:@"身份证正面"];
        [bgImageView addSubview:topImageView];
        
        UIImageView *secondImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _maskView.shwoView.frame.size.height+_spaceWithCutRect,_maskView.shwoView.frame.size.width, _maskView.shwoView.frame.size.height)];
        secondImageView.image = [UIImage imageNamed:@"身份证背面"];
        [bgImageView addSubview:secondImageView];
        [self.view addSubview:bgImageView];
        
        UIImage * newsImages = [Tools imageFromView:bgImageView];
        finallImage = [Tools imageFromImage:newsImages atFrame:CGRectMake(0, 0, bgImageView.frame.size.width, bgImageView.frame.size.height)];
        [bgImageView removeFromSuperview];
    }
    else{
        UIImage *image = [Tools imageFromView:_maskView.shwoView];
        UIImage *images = [Tools imageFromView:_maskView.shwoView2];
        finallImage = [Tools addImage:image toImage:images andSpace:_spaceWithCutRect];
    }
    
    WatermarkContent1ViewController *vc = [[WatermarkContent1ViewController alloc]init];
    vc.headerImage = finallImage;
    vc.isDoubleWaterMark = YES;
    [self.navigationController pushViewController:vc animated:NO];
    
}


//显示点击拍照正面的视图
-(void)setTopClickView{
    
    [_showTopTakePhotoView removeFromSuperview];
    _showTopTakePhotoView = [[UIView alloc]initWithFrame:_maskView.WillCupRect];
    _showTopTakePhotoView.backgroundColor = [UIColor lightGrayColor];
    UILabel *label = [[UILabel alloc]initWithFrame:_showTopTakePhotoView.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"拍照正面";
    label.textColor = [UIColor whiteColor];
    [_showTopTakePhotoView addSubview:label];
    
    UILabel*showLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, _showTopTakePhotoView.bounds.size.height-25, 200, 17)];
    showLabel.textColor = [UIColor whiteColor];
    showLabel.text = @"可旋转,可缩放";
    [_showTopTakePhotoView addSubview:showLabel];
    
    [self.view addSubview:_showTopTakePhotoView];
    
    UITapGestureRecognizer*selectToptap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectToptapAction)];
    [_showTopTakePhotoView addGestureRecognizer:selectToptap];
    
}
/*
 *  点击手势作用与上面的拍照正面
 */
-(void)selectToptapAction{
    _isTopArea = YES;
    _currentSelectImageView = _maskView.shwoView;
    if (!_maskView.shwoView2.isSetImage) {
        //设置显示拍照反面
        [self setSecondClickView];
    }
    [_showTopTakePhotoView removeFromSuperview];
    //    _takephotoBtn.selected = NO;
    if (![self.session isRunning]) {
        
        [self.session startRunning];
    }
    
    [self showFocusKuang:_maskView.shwoView.center];
    [self focusAtPoint:_maskView.shwoView.center];
    
}

//显示点击拍照反面的视图
-(void)setSecondClickView{
    [_showSecondTakePhotoView removeFromSuperview];
    _showSecondTakePhotoView = [[UIView alloc]initWithFrame:_maskView.WillCupRect2];
    _showSecondTakePhotoView.backgroundColor = [UIColor lightGrayColor];
    UILabel *label = [[UILabel alloc]initWithFrame:_showSecondTakePhotoView.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"拍照反面";
    label.textColor = [UIColor whiteColor];
    [_showSecondTakePhotoView addSubview:label];
    UILabel*showLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, _showSecondTakePhotoView.bounds.size.height-25, 200, 17)];
    showLabel.textColor = [UIColor whiteColor];
    showLabel.text = @"可旋转,可缩放";
    [_showSecondTakePhotoView addSubview:showLabel];
    
    [self.view addSubview:_showSecondTakePhotoView];
    
    UITapGestureRecognizer*selectSecondtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectSecondtapAction)];
    [_showSecondTakePhotoView addGestureRecognizer:selectSecondtap];
    
}
/*
 *  点击手势作用与下面的拍照反面
 */
-(void)selectSecondtapAction{
    _isTopArea = NO;
    _currentSelectImageView = _maskView.shwoView2;
    if (!_maskView.shwoView.isSetImage) {
        //设置显示第一个拍照正面
        [self setTopClickView];
    }
    [_showSecondTakePhotoView removeFromSuperview];
    //    _takephotoBtn.selected = NO;
    if (![self.session isRunning]) {
        
        [self.session startRunning];
    }
    [self showFocusKuang:_maskView.shwoView2.center];
    [self focusAtPoint:_maskView.shwoView2.center];

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

