//
//  BusinessLicenseViewController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BusinessLicenseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ClipViewController.h"
#import "CupView.h"
#import "UIImage+Extension.h"
#import "WatermarkContent1ViewController.h"
#import "OutputSeting1ViewController.h"
#import <UIView+Toast.h>
#import <Masonry.h>
#import "EnlargeButton.h"
#import "StyleView.h"
#import "PhotoShowViewController.h"
#import "CupTwoView.h"
#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height

@interface BusinessLicenseViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>
{
    CGRect _waterMarkViewRect;
    CGRect _toRect;//剪裁图片的尺寸
    UIButton *_backImageButton;//恢复原图按钮
    BOOL _style;//样式选择 是否为单张,默认是单张
}
@property(nonatomic,strong)StyleView *styleView;//样式选择
@property(nonatomic,strong)ImageShowView *currentSelectView;//当前选择的是上面还是下面  双面用
@property(nonatomic,strong)CupTwoView *maskView;//蒙版显示层 双面用
@property(nonatomic, nonnull,strong)UIView *showGrayView;//上面的显示遮罩层  双面用
@property(nonatomic, nonnull,strong)UIView *secondShowGrayView;//下面的显示遮罩层  双面用
@property(nonnull,strong)UIView *showTopTakePhotoView;//上面的显示拍照  双面用
@property(nonnull,strong)UIView *showSecondTakePhotoView;//下面的显示拍照   双面用

//@property(nonatomic,strong)UIRotationGestureRecognizer *rotaitonGest;//旋转手势
//@property(nonatomic,strong)UIPinchGestureRecognizer *pinchGest;//捏合手势
//@property(nonatomic,strong)UIPanGestureRecognizer *panGest;//拖拽手势

@property(nonatomic,strong)UIRotationGestureRecognizer *rotaitonGestForView;//旋转手势
@property(nonatomic,strong)UIPinchGestureRecognizer *pinchGestForView;//捏合手势
@property(nonatomic,strong)UIPanGestureRecognizer *panGestForView;//拖拽手势

@property(nonatomic,strong)UIImageView *focusView;//聚焦图片

/**
 *  AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
 */
@property (nonatomic, strong) AVCaptureSession* session;
/**
 *  输入设备
 */
@property (nonatomic, strong) AVCaptureDeviceInput* videoInput;
/**
 *  照片输出流
 */
@property (nonatomic, strong) AVCaptureStillImageOutput* stillImageOutput;
/**
 *  预览图层
 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer* previewLayer;

/**
 *  记录开始的缩放比例
 */
@property(nonatomic,assign)CGFloat beginGestureScale;
/**
 * 最后的缩放比例
 */
@property(nonatomic,assign)CGFloat effectiveScale;

@property (nonatomic, strong) AVCaptureConnection *stillImageConnection;

@property (nonatomic, strong) NSData  *jpegData;

@property (nonatomic, assign) CFDictionaryRef attachments;

@property (strong,nonatomic) UIView *toolView;
@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UIActivityIndicatorView *actiview;//显示正在初始化相机
@property (nonatomic,strong) UIImageView * largeImageView;//显示最大的图片

@property(nonatomic,assign)BOOL isSetImage;//是否拍照了

@end

@implementation BusinessLicenseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_isSetImage) {
        if (self.session) {
            [self.session startRunning];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    if ([self.session isRunning]) {
        [self.session stopRunning];
    }
}

/*
 *  leftAction
 */
-(void)leftAction{
    if (self.styleView == nil) {
        self.styleView = [[StyleView alloc]init];
        [self.view addSubview:self.styleView];
        WeakSelf;
        self.styleView.selectBlock = ^(NSInteger index) {
          
            if (_style == index-1) {
                return ;
            }
            
            if (index==1) {
                _style = NO;
                weakSelf.maskView.hidden = YES;
                weakSelf.showTopTakePhotoView.hidden = YES;
                weakSelf.showSecondTakePhotoView.hidden = YES;
                weakSelf.showGrayView.hidden = YES;
                weakSelf.secondShowGrayView.hidden = YES;
                [weakSelf dealMarkButtonAction];
            }
            else{
                _style = YES;
                weakSelf.maskView.hidden = NO;
                weakSelf.maskView.shwoView.image = nil;
                weakSelf.maskView.shwoView2.image = nil;
                [weakSelf createSecondTipView];
                _currentSelectView = weakSelf.maskView.shwoView;
                [weakSelf dealMarkButtonAction];
            }
        };
    }
    else{
        if (self.styleView.hidden) {
            [self.styleView show];
            [self.view bringSubviewToFront:self.styleView];
        }
        else{
            self.styleView.hidden = YES;
        }
    }

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"这个调用顺序是这样");
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"样式选择" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    
    [self initView];
    [self initAVCaptureSession];
    
    [Tools acquireMediaType:AVMediaTypeVideo Auth:^(BOOL grant){
        [_actiview stopAnimating];
        [_actiview removeFromSuperview];
        
        if (grant) {
//            [self.session startRunning];
            [self resetFocusAndExposureModes];
            [self showfocus:_bgView.center];
        }
        else{
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"获取授权" message:@"您已设置关闭使用相机,请在设备的设置-隐私-相机中允许使用。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定" ,nil];
            [alertView show];
        }
    }];
    
    self.title = @"拍照";
    
}

-(void)viewDidLayoutSubviews{
    self.previewLayer.frame = _bgView.bounds;
    _toRect = [_bgView convertRect:_bgView.bounds toView:[UIApplication sharedApplication].delegate.window];
}

/*
 *  加载双面选择的视图
 */
-(CupTwoView *)maskView{
    if (_maskView==nil) {
        WeakSelf;
        _maskView = [[CupTwoView alloc]initWithFrame:_bgView.bounds];
        _maskView.takePhotoBlack = ^(ImageShowView *shwoView, BOOL first) {
            _currentSelectView = shwoView;
            if (first) {
                if (weakSelf.maskView.shwoView.isSetImage&&weakSelf.maskView.shwoView2.isSetImage) {
                    [weakSelf setGrayView:YES];
                }
                else{
                    if (!weakSelf.maskView.shwoView2.isSetImage) {
                        [weakSelf createSecondTipView];//显示拍照反面
                    }
                }
            }
            else{
                if (weakSelf.maskView.shwoView.isSetImage&&weakSelf.maskView.shwoView2.isSetImage) {
                    [weakSelf setGrayView:NO];
                }
                else{
                    if (!weakSelf.maskView.shwoView.isSetImage) {
                        [weakSelf createTopTipView];//显示拍照正面
                    }
                }
            }
        };
        [self.view addSubview:_maskView];
    }
    return _maskView;
}


/*
 *  创建提示层
 */
-(void)createTopTipView{
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
    if (!_maskView.shwoView2.isSetImage) {
        //设置显示拍照反面
        [self createSecondTipView];
    }
    _currentSelectView = _maskView.shwoView;
    [_showTopTakePhotoView removeFromSuperview];
    if (self.session) {
        self.previewLayer.hidden = NO;
        [self.session startRunning];
    }
    
    [self focusAtPoint:_maskView.shwoView.center];
    
}


/*  创建提示层
*/
-(void)createSecondTipView{
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
    if (!_maskView.shwoView.isSetImage) {
        //设置显示第一个拍照正面
        [self createTopTipView];
    }
    _currentSelectView = _maskView.shwoView2;
    [_showSecondTakePhotoView removeFromSuperview];
    if (self.session) {
        self.previewLayer.hidden = NO;
        [self.session startRunning];
    }
    [self focusAtPoint:_maskView.shwoView2.center];
    
}


//显示灰色视图
//是否是上层
-(void)setGrayView:(BOOL)istop{
    if (istop) {
        self.secondShowGrayView.hidden = NO;
    }
    else{
        self.showGrayView.hidden = NO;
    }
}

-(UIView *)showGrayView{
    if (_showGrayView==nil) {
        CGRect rect = _maskView.WillCupRect;
//        rect.origin.y -=0.5;
//        rect.size.height+=1;
        _showGrayView = [[UIView alloc]initWithFrame:rect];
        _showGrayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self.view addSubview:_showGrayView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTopGraytapAction)];
        [_showGrayView addGestureRecognizer:tap];
    }
    return _showGrayView;
}

-(UIView *)secondShowGrayView{
    if (_secondShowGrayView==nil) {
        CGRect rect = _maskView.WillCupRect2;
//        rect.origin.y -=0.5;
//        rect.size.height+=1;
        _secondShowGrayView = [[UIView alloc]initWithFrame:rect];
        _secondShowGrayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self.view addSubview:_secondShowGrayView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectSecondGraytapAction)];
        [_secondShowGrayView addGestureRecognizer:tap];
    }
    return _secondShowGrayView;
}

/*
 *  点击手势作用与上面的选择相册
 */
-(void)selectTopGraytapAction{
    self.showGrayView.hidden = YES;
    self.secondShowGrayView.hidden = NO;
    _currentSelectView = _maskView.shwoView;

}


/*
 *  点击手势作用与下面的选择相册
 */
-(void)selectSecondGraytapAction{
    
    self.showGrayView.hidden = NO;
    self.secondShowGrayView.hidden = YES;
    _currentSelectView = _maskView.shwoView2;

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


-(void)initView{
    
    [self loadBottom];
    
    _bgView = [[UIView alloc]initWithFrame:CGRectZero];
    _bgView.backgroundColor = [UIColor clearColor];
    _bgView.userInteractionEnabled = YES;
    _bgView.clipsToBounds = YES;
    [self.view addSubview:_bgView];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.mas_equalTo(self.view).mas_offset(0);
        make.bottom.mas_equalTo(_toolView.mas_top).mas_offset(0);

    }];
    
    _largeImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _largeImageView.userInteractionEnabled = YES;
    _largeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_bgView addSubview:_largeImageView];
    
    [_largeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.left.right.mas_equalTo(_bgView).mas_offset(0);
        
    }];
    
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
    
    _panGestForView = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pangessaction:)];
    _panGestForView.delegate = self;
    _panGestForView.maximumNumberOfTouches  = 1;
    _panGestForView.minimumNumberOfTouches  = 1;
    
    [_bgView addGestureRecognizer:_panGestForView];
    //旋转
    
    _rotaitonGestForView = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationView:)];
    _rotaitonGestForView.delegate =self;
    [_bgView addGestureRecognizer:_rotaitonGestForView];
    
    //捏合
    _pinchGestForView = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinView:)];
    _pinchGestForView.delegate =self;
    [_bgView addGestureRecognizer:_pinchGestForView];
    
}

/*
 *  加载底部
 */
-(void)loadBottom{
    
    if (_toolView==nil) {
        _toolView = [[UIView alloc]initWithFrame:CGRectZero];
        _toolView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_toolView];
        
        [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.mas_equalTo(self.view).mas_offset(0);
            make.height.mas_offset(69);
            make.bottom.mas_equalTo(IOS11_OR_LATER?self.view.mas_safeAreaLayoutGuideBottom:self.view.mas_bottom).mas_offset(0);
            
        }];
        
        UIButton *setMarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [setMarkBtn setImage:[UIImage imageNamed:@"xiangce"] forState:UIControlStateNormal];
        [setMarkBtn setTitle:@"相册" forState:UIControlStateNormal];
        [setMarkBtn setTitleColor:[UIColor colorWithHexString:@"a0a0a2"] forState:UIControlStateNormal];
        setMarkBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        setMarkBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -46, -30, -20);
        setMarkBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
        [setMarkBtn addTarget:self action:@selector(setMarkButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *takeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [takeBtn setImage:[UIImage imageNamed:@"拍照"] forState:UIControlStateNormal];
        [takeBtn addTarget:self action:@selector(takePhotoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *markBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [markBtn setImage:[UIImage imageNamed:@"chongpai"] forState:UIControlStateNormal];
        [markBtn setTitle:@"重拍" forState:UIControlStateNormal];
        [markBtn setTitleColor:[UIColor colorWithHexString:@"a0a0a2"] forState:UIControlStateNormal];
        markBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        markBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -46, -30, -20);
        markBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0);

        [markBtn addTarget:self action:@selector(dealMarkButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_toolView addSubview:setMarkBtn];
        [_toolView addSubview:takeBtn];
        [_toolView addSubview:markBtn];
        
        [takeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(_toolView.mas_centerX);
            make.centerY.mas_equalTo(_toolView.mas_centerY);
            make.width.height.mas_offset(48);
        }];
        
        [setMarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(_toolView).mas_offset(18);
            make.right.mas_equalTo(takeBtn.mas_left).mas_offset(-80);
            make.width.mas_offset(26);
            make.height.mas_offset(48);
        }];
        
        
        [markBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(_toolView).mas_offset(18);
            make.left.mas_equalTo(takeBtn.mas_right).mas_offset(80);
            make.width.mas_offset(26);
            make.height.mas_offset(48);
            
        }];
    }
}

/*
 *  拖动手势
 */
-(void)pangessaction:(UIPanGestureRecognizer*)panGest{
    if (_isSetImage) {
        
        if (panGest.state == UIGestureRecognizerStateBegan) {
            [self createReturnImageButton];

//            //  [MobClick event:@"single_move_photo" attributes:@{@"单面移动照片":@"拖动"}];//[单面 移动照片]
        }
        
        if (panGest.state == UIGestureRecognizerStateBegan || panGest.state == UIGestureRecognizerStateChanged) {
            CGPoint trans = [panGest translationInView:panGest.view];
            NSLog(@"%@",NSStringFromCGPoint(trans));
            
            //设置图片移动
            CGPoint center =  _largeImageView.center;
            center.x += trans.x;
            center.y += trans.y;
            _largeImageView.center = center;
            //清除累加的距离
            [panGest setTranslation:CGPointZero inView:panGest.view];
        }
    }else{
    }
}

-(void)pinView:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    if (_isSetImage) {
        UIView *view = _largeImageView;
        
        if (pinchGestureRecognizer.numberOfTouches<2) {
            return;
        }
        CGPoint onoPoint = [pinchGestureRecognizer locationOfTouch:0 inView:pinchGestureRecognizer.view];
        CGPoint twoPoint = [pinchGestureRecognizer locationOfTouch:1 inView:pinchGestureRecognizer.view];
        if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan) {
            
            [self createReturnImageButton];
            
            //  [MobClick event:@"single_move_photo" attributes:@{@"单面移动照片":@"放大缩小"}];
            //        }
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
        }
        if (pinchGestureRecognizer.state == UIGestureRecognizerStateFailed||pinchGestureRecognizer.state == UIGestureRecognizerStateEnded) {
            [Tools setDefaultAnchorPointforView:view];
        }
        
        NSLog(@"%f",pinchGestureRecognizer.scale);
        if (pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
            view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
            pinchGestureRecognizer.scale = 1;
        }
        
    }
}

-(void)rotationView:(UIRotationGestureRecognizer *)rotationGestureRecognizer{
    if (_isSetImage) {
        //旋转角度.也是一个累加过程
        if (rotationGestureRecognizer.numberOfTouches<2) {
            return;
        }
        NSLog(@"%f转换成角度%f",rotationGestureRecognizer.rotation,rotationGestureRecognizer.rotation/M_PI*180);
        CGPoint onoPoint = [rotationGestureRecognizer locationOfTouch:0 inView:rotationGestureRecognizer.view];
        CGPoint twoPoint = [rotationGestureRecognizer locationOfTouch:1 inView:rotationGestureRecognizer.view];
        UIView *view = _largeImageView;
        
        if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan) {
            [self createReturnImageButton];
//            //  [MobClick event:@"single_move_photo" attributes:@{@"单面移动照片":@"旋转"}];
            //        }
            onoPoint =  [rotationGestureRecognizer.view convertPoint:onoPoint toView:view];
            twoPoint =  [rotationGestureRecognizer.view convertPoint:twoPoint toView:view];
            NSLog(@"转换后坐标是%@",NSStringFromCGPoint(onoPoint));
            NSLog(@"转换后坐标是%@",NSStringFromCGPoint(twoPoint));
            
            CGPoint anchorPoint;
            anchorPoint.x = (onoPoint.x + twoPoint.x) / 2 / view.bounds.size.width;
            anchorPoint.y = (onoPoint.y + twoPoint.y) / 2 / view.bounds.size.height;
            NSLog(@"旋转的锚点是%@",NSStringFromCGPoint(anchorPoint));
            
            [Tools setAnchorPoint:anchorPoint forView:view];
        }
        if (rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
            
            view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
            [rotationGestureRecognizer setRotation:0];
            
        }
        if (rotationGestureRecognizer.state == UIGestureRecognizerStateEnded||rotationGestureRecognizer.state == UIGestureRecognizerStateFailed) {
            
            [Tools setDefaultAnchorPointforView:view];
        }
    }
}

/**
 *  多个手势同时存在的代理,不能忘记
 */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}


- (void)initAVCaptureSession{
    
    
    NSError *error;
    
    self.effectiveScale = 1.0;
    
    AVCaptureDevice *device = [self cameraWithPosition:AVCaptureDevicePositionBack];
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    //输出设置。AVVideoCodecJPEG   输出jpeg格式图片
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    self.session = [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPresetInputPriority;
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    //            [self.session startRunning];
    
    //初始化预览图层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
        
        [_bgView.layer addSublayer:self.previewLayer];
        
    } completion:^(BOOL finished) {
        
    }];
}


- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ){
            return device;
        }
    return nil;
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
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    if (CGRectContainsPoint(_toolView.frame,point)) {
        //触摸在tool层
        return;
    }
    if (!_style) {
        //单张
        if (_isSetImage) {
            return;
        }
        [self showfocus:point];
    }
    else{
        if (_maskView.shwoView.isSetImage&&CGRectContainsPoint(_maskView.shwoView.frame, point)) {
            return;
        }
        if (_maskView.shwoView2.isSetImage&&CGRectContainsPoint(_maskView.shwoView2.frame, point)) {
            return;
        }
        [self showfocus:point];
    }
    
}

/*
 *  显示聚焦框
 */
-(void)showfocus:(CGPoint)point{
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

//获取设备方向
-(AVCaptureVideoOrientation)avOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation
{
    AVCaptureVideoOrientation result = (AVCaptureVideoOrientation)deviceOrientation;
    if ( deviceOrientation == UIDeviceOrientationLandscapeLeft )
        result = AVCaptureVideoOrientationLandscapeRight;
    else if ( deviceOrientation == UIDeviceOrientationLandscapeRight )
        result = AVCaptureVideoOrientationLandscapeLeft;
    return result;
}


/*
 *  创建恢复原图按钮
 */
-(void)createReturnImageButton{
    
    if (_backImageButton==nil) {
        _backImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backImageButton.frame = CGRectMake(kScreenWidth-80, 10, 60, 30);
        _backImageButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_backImageButton setTitle:@"原图" forState:UIControlStateNormal];
        [_backImageButton setBackgroundImage:[UIImage imageNamed:@"原图按钮"] forState:UIControlStateNormal];
        [_backImageButton addTarget:self action:@selector(returnBackImage) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backImageButton];
    }
    _backImageButton.hidden = NO;
}

/*
 *  返回原图
 */
-(void)returnBackImage{
    _backImageButton.hidden = YES;
    _largeImageView.transform = CGAffineTransformIdentity;
    _largeImageView.frame = _bgView.bounds;
}

/*
 *  重新拍照
 */
-(void)dealMarkButtonAction{
    [self rightButtonImage:nil RightButtonTitle:@"" rightButtonTarget:nil rightButtonAction:nil];
    _currentSelectView.image = nil; //设置为空
    _currentSelectView.backTopButton.hidden = YES;//隐藏右上角 原图按钮
    self.showGrayView.hidden = YES; //隐藏遮罩
    self.secondShowGrayView.hidden = YES; //隐藏遮罩
    _isSetImage = NO;
    _largeImageView.image = nil;
    [self returnBackImage];
    _previewLayer.hidden = NO;
    [self.session startRunning];
}

//相册选择
-(void)setMarkButtonAction:(UIButton*)sender{
    [self.session stopRunning];
    [Tools acquirePhotoAuth:^(BOOL grant) {
        if (grant) {
            
            PhotoShowViewController *vc = [[PhotoShowViewController alloc]init];
            vc.isNomalPush = YES;
            
            vc.selectBlock = ^(NSMutableArray *imageArr) {
                [Tools showGessTipView];

                _previewLayer.hidden = YES;
                if ([self.session isRunning]) {
                    [self.session stopRunning];
                }
                for (UIImage *result in imageArr) {
                    if (!_style) {
                        //单面
                        _isSetImage = YES;
                        [self rightButtonImage:nil RightButtonTitle:@"下一步" rightButtonTarget:self rightButtonAction:@selector(nextAction)];
                        _backImageButton.hidden = YES;
                        _largeImageView.transform = CGAffineTransformIdentity;
                        _largeImageView.image = result;
                        _largeImageView.contentMode = UIViewContentModeScaleAspectFit;
                        _largeImageView.frame = _bgView.bounds;
                    }
                    else{
                        //多张
                        if (_currentSelectView == _maskView.shwoView) {
                            _maskView.shwoView.image = result;
                            _maskView.shwoView.backTopButton.hidden = YES;
                        }
                        else{
                            _maskView.shwoView2.backTopButton.hidden = YES;
                            _maskView.shwoView2.image = result;
                        }
                        
                        if (_maskView.shwoView.isSetImage && _maskView.shwoView2.isSetImage) {
                            [self rightButtonImage:nil RightButtonTitle:@"下一步" rightButtonTarget:self rightButtonAction:@selector(nextAction)];
                        }
                    }
                    
                }
                
            };
            [self.navigationController pushViewController:vc animated:YES];
        } else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"获取授权" message:@"您已设置关闭使用相册,请在设备的设置-隐私-相册中允许使用。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定" ,nil];
            [alertView show];

        }
    }];
    
}

//照相
- (IBAction)takePhotoButtonClick:(UIButton *)sender {
    
    
    _stillImageConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if(!_stillImageConnection){
        NSLog(@"拍照失败!");
        return;
    }
    
    UIDeviceOrientation curDeviceOrientation = [[UIDevice currentDevice] orientation];
    AVCaptureVideoOrientation avcaptureOrientation = [self avOrientationForDeviceOrientation:curDeviceOrientation];
    [_stillImageConnection setVideoOrientation:avcaptureOrientation];
    [_stillImageConnection setVideoScaleAndCropFactor:self.effectiveScale];
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:_stillImageConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        
        if (imageDataSampleBuffer==nil) {
            return ;
        }
        
        [self.session stopRunning];
        self.previewLayer.hidden = YES;
        [Tools showGessTipView];
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [UIImage imageWithData:imageData];
        image = [Tools fixOrientation:image];

        if (!_style) {
            //单面
            //  [MobClick event:@"single_take_photo"];//[单面 拍照]
            _bgView.userInteractionEnabled = YES;
            [self rightButtonImage:nil RightButtonTitle:@"下一步" rightButtonTarget:self rightButtonAction:@selector(nextAction)];
            
            ////        NSLog(@"%@",NSStringFromCGRect(_maskView.WillCupRect));
            _largeImageView.image = [image clipImageWithRect:_toRect];
            _isSetImage = YES;
        }
        else{
            //双面
            if ([_currentSelectView isEqual:_maskView.shwoView2]) {
                //  [MobClick event:@"double_take_photo_b"];//[双面 拍照b]
            }
            else{
                //  [MobClick event:@"double_take_photo_a"];//[双面 拍照a]
            }
            _currentSelectView.image = [image clipImageWithRect:[self changeToRect:_currentSelectView.frame]];
            if (_maskView.shwoView.isSetImage && _maskView.shwoView2.isSetImage) {
                [self rightButtonImage:nil RightButtonTitle:@"下一步" rightButtonTarget:self rightButtonAction:@selector(nextAction)];
            }
        }
        
    }];
    
}
/*
 *  转换坐标
 */
-(CGRect)changeToRect:(CGRect)rect{
    return [_maskView convertRect:rect toView:[UIApplication sharedApplication].delegate.window];
}

//下一步 跳转到输出设置
-(void)nextAction{
    
//    //  [MobClick event:@"single_next"];//[单面 下一步]
    
    NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:kWaterMarkModel];
    
    WaterMarkMode*model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    
    model.waterMarkPoint = [NSValue valueWithCGPoint:_waterMarkViewRect.origin];
    
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kWaterMarkModel];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (!_style) {
        
        UIImage * image = [Tools imageFromView:_bgView];
        image = [Tools imageFromImage:image atFrame:_bgView.frame];
    
    WatermarkContent1ViewController *vc = [[WatermarkContent1ViewController alloc] init];
//    viewController.headerImage = image;
//    [self.navigationController pushViewController: viewController animated: YES];
    
//    OutputSeting1ViewController * vc = [[OutputSeting1ViewController alloc]init];
//    if (!_isSetImage) {
//        [self.navigationController.view makeToast:@"需拍照完,才能下一步"];
//        return;
//    }else{
        vc.headerImage = image;
//    }
    
    [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        BOOL showTopreturnBtn = NO;
        if (!_maskView.shwoView.backTopButton.hidden) {
            _maskView.shwoView.backTopButton.hidden = YES;
            showTopreturnBtn = YES;
        }
        _maskView.shwoView.layer.borderColor = [UIColor whiteColor].CGColor;
        UIImage *image = [Tools imageFromView:_maskView.shwoView];
        ViewBorderRadius(_maskView.shwoView, 0, 1, [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1]);
        
        if (showTopreturnBtn) {
            _maskView.shwoView.backTopButton.hidden = NO;
        }
        BOOL showsecondreturnBtn = NO;
        if (!_maskView.shwoView2.backTopButton.hidden) {
            _maskView.shwoView2.backTopButton.hidden = YES;
            showsecondreturnBtn = YES;
        }
        _maskView.shwoView2.layer.borderColor = [UIColor whiteColor].CGColor;
        UIImage *images = [Tools imageFromView:_maskView.shwoView2];
        ViewBorderRadius(_maskView.shwoView2, 0, 1, [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1]);
        if (showsecondreturnBtn) {
            _maskView.shwoView2.backTopButton.hidden = NO;
        }
        
        UIImage *finallImage = [Tools addImage:image toImage:images andSpace:_maskView.WillCupRect2.origin.y-CGRectGetMaxY(_maskView.shwoView.frame)];
        
        WatermarkContent1ViewController *vc = [[WatermarkContent1ViewController alloc]init];
        vc.headerImage = finallImage;
        vc.isDoubleWaterMark = YES;
        [self.navigationController pushViewController:vc animated:true];

    }
}


//缩放手势 用于调整焦距
- (void)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer{
    
    BOOL allTouchesAreOnThePreviewLayer = YES;
    NSUInteger numTouches = [recognizer numberOfTouches], i;
    for ( i = 0; i < numTouches; ++i ) {
        CGPoint location = [recognizer locationOfTouch:i inView:self.view];
        CGPoint convertedLocation = [self.previewLayer convertPoint:location fromLayer:self.previewLayer.superlayer];
        if ( ! [self.previewLayer containsPoint:convertedLocation] ) {
            allTouchesAreOnThePreviewLayer = NO;
            break;
        }
    }
    
    if ( allTouchesAreOnThePreviewLayer ) {
        
        self.effectiveScale = self.beginGestureScale * recognizer.scale;
        if (self.effectiveScale < 1.0){
            self.effectiveScale = 1.0;
        }
        
        NSLog(@"%f-------------->%f------------recognizerScale%f",self.effectiveScale,self.beginGestureScale,recognizer.scale);
        
        CGFloat maxScaleAndCropFactor = [[self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo] videoMaxScaleAndCropFactor];
        
        NSLog(@"%f",maxScaleAndCropFactor);
        if (self.effectiveScale > maxScaleAndCropFactor)
            self.effectiveScale = maxScaleAndCropFactor;
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:.025];
        [self.previewLayer setAffineTransform:CGAffineTransformMakeScale(self.effectiveScale, self.effectiveScale)];
        [CATransaction commit];
        
    }
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( [gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] ) {
        self.beginGestureScale = self.effectiveScale;
    }
    return YES;
}


@end
