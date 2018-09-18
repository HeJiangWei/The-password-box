//
//  OutputSeting1ViewController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OutputSeting1ViewController.h"
#import "WaterMarkMode.h"
#import <KVNProgress.h>
#import "SaveSuccess1ViewController.h"
#import <PhotosUI/PhotosUI.h>
@interface OutputSeting1ViewController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (nonatomic , assign) CGFloat lastScaleFactor;//图片缩放比例
@property (nonatomic,strong) UIImage *imgTest;//合成之前的图片
@property (nonatomic,strong) UIImage * img;//没有经过处理的图片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLine;

//水印输出
@property (weak, nonatomic) IBOutlet UIView *waterMarkOutputBackView;
@property (weak, nonatomic) IBOutlet UISwitch *blackAndWhiteSwitch;//转为黑白颜色
@property (weak, nonatomic) IBOutlet UISlider *saveDealPhotoSlider;//图片存储质量
//@property (weak, nonatomic) IBOutlet UIButton *saveTheOriginalImageButton;
@property (weak, nonatomic) IBOutlet UILabel *photoLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *photoSizeLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveLowPhotoButton;//低质量
@property (weak, nonatomic) IBOutlet UIButton *saveMediumPhotoButton;//中等质量
@property (weak, nonatomic) IBOutlet UIButton *saveHighPhotoButton;//高质量
@property (weak, nonatomic) IBOutlet UIButton *theOriginalImageButton;//原图
@property (weak, nonatomic) IBOutlet UITextField *leftTF;
@property (weak, nonatomic) IBOutlet UITextField *rightTF;

@property (nonatomic,assign) CGRect oldFrame;

@property (nonatomic , strong) UIButton * savePhotoQualitySelectedButton;//记录当前点击保存图片质量的按钮
@property (nonatomic,strong) UIImage * scalePhoto;//压缩后的图片，需要保存的图片
@property (nonatomic,assign) CGFloat sliderValue;//图片压缩尺寸大小百分比
@property (nonatomic,assign) CGFloat photoQuality;//图片压缩质量百分比

@property (nonatomic,strong) WaterMarkMode * model;

@end

@implementation OutputSeting1ViewController

-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
//    _topLine.constant = self.view.safeAreaInsets.top;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    if (CGRectEqualToRect(_oldFrame, CGRectZero)) {
//        _oldFrame = self.headerImageView.frame;
//    }
//    NSLog(@"frame===%@",NSStringFromCGRect(self.headerImageView.frame));
    _oldFrame = self.mainView.frame;
 }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:kWaterMarkModel];
    if (modelData==nil) {
        _model = [WaterMarkMode getDefaultModelWithEndImageSize:_headerImage.size];
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:_model];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kWaterMarkModel];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        _model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    }

    self.title = @"保存设置";
    [self rightButtonImage:nil RightButtonTitle:@"保存" rightButtonTarget:self rightButtonAction:@selector(savePhoto)];
    
    self.lastScaleFactor = 1;
    self.img = self.headerImage;
    self.imgTest = self.headerImage;
    
    self.mainView.userInteractionEnabled = YES;
    self.headerImageView.userInteractionEnabled = YES;
    if (_hasWaterMark) {
        self.headerImage = [UIImage addInImage:self.imgTest withModel:_model IsDoubleImage:_isDoubleWaterMark];
    }
    self.headerImageView.image = self.headerImage;
    [self.headerImageView setContentMode:UIViewContentModeScaleAspectFit];
    NSLog(@"viewdidloadframe===%@",NSStringFromCGRect(self.headerImageView.frame));

    self.mainView.clipsToBounds = YES;
    UIPinchGestureRecognizer* pinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [pinchGR setDelegate:self];
//    [self.mainView addGestureRecognizer:pinchGR];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
//    [self.mainView  addGestureRecognizer:pan];
    
    self.sliderValue = 1;
    self.photoQuality = 1;
    self.scalePhoto = self.headerImage;
    self.scalePhoto = [self dealPhotoWithSlider:1 photoQuality:1];
    NSData * imageData = UIImageJPEGRepresentation(self.scalePhoto,1);
    CGFloat length = [imageData length]/1024.0;
    self.photoLengthLabel.text = [NSString stringWithFormat:@"%.0fKB",length];
    _leftTF.userInteractionEnabled = NO;
    _rightTF.userInteractionEnabled = NO;
    _leftTF.textAlignment = NSTextAlignmentCenter;
    _rightTF.textAlignment = NSTextAlignmentCenter;
    
    _leftTF.text = [NSString stringWithFormat:@"%.0f",_headerImage.size.width];
    _rightTF.text = [NSString stringWithFormat:@"%.0f",_headerImage.size.height];
    
//    self.photoSizeLabel.text = [NSString stringWithFormat:@"%.0fX%.0f (单位:像素)",self.headerImage.size.width ,self.headerImage.size.height];
    
    self.saveLowPhotoButton.tag = 60;
    self.saveMediumPhotoButton.tag = 61;
    self.saveHighPhotoButton.tag = 62;
    self.theOriginalImageButton.tag = 63;
    
    self.saveLowPhotoButton.layer.cornerRadius = _saveLowPhotoButton.frame.size.height/2;
    self.saveMediumPhotoButton.layer.cornerRadius = _saveLowPhotoButton.frame.size.height/2;
    self.saveHighPhotoButton.layer.cornerRadius = _saveLowPhotoButton.frame.size.height/2;
    self.theOriginalImageButton.layer.cornerRadius = _saveLowPhotoButton.frame.size.height/2;
    self.saveLowPhotoButton.layer.masksToBounds = YES;
    self.saveMediumPhotoButton.layer.masksToBounds = YES;
    self.saveHighPhotoButton.layer.masksToBounds = YES;
    self.theOriginalImageButton.layer.masksToBounds = YES;
    
    [self.saveLowPhotoButton addTarget:self action:@selector(changePhotoQuality:) forControlEvents:UIControlEventTouchUpInside];
    [self.saveMediumPhotoButton addTarget:self action:@selector(changePhotoQuality:) forControlEvents:UIControlEventTouchUpInside];
    [self.saveHighPhotoButton addTarget:self action:@selector(changePhotoQuality:) forControlEvents:UIControlEventTouchUpInside];
    [self.theOriginalImageButton addTarget:self action:@selector(changePhotoQuality:) forControlEvents:UIControlEventTouchUpInside];
    self.savePhotoQualitySelectedButton = self.theOriginalImageButton;
    [self.theOriginalImageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.theOriginalImageButton.backgroundColor = [UIColor colorWithHexString:@"0473F5"];
    
    //水印输出设置
    [self.blackAndWhiteSwitch setOn:NO];
    [self.blackAndWhiteSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    self.saveDealPhotoSlider.minimumValue = 0.2;
    self.saveDealPhotoSlider.maximumValue = 1;
    self.saveDealPhotoSlider.value = 1;
    [self.saveDealPhotoSlider addTarget:self action:@selector(saveDealPhotoAction:) forControlEvents:UIControlEventValueChanged];
    
}

//捏合手势的回调方法
- (void)pinchAction:(UIPinchGestureRecognizer*)pinchGestureRecognizer{
    
//    UIView *view = self.headerImageView;
    
//    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan) {
//        CGPoint onoPoint = [pinchGestureRecognizer locationOfTouch:0 inView:pinchGestureRecognizer.view];
//        CGPoint twoPoint = [pinchGestureRecognizer locationOfTouch:1 inView:pinchGestureRecognizer.view];
//        onoPoint =  [pinchGestureRecognizer.view convertPoint:onoPoint toView:view];
//        twoPoint =  [pinchGestureRecognizer.view convertPoint:twoPoint toView:view];
//        CGPoint anchorPoint;
//        anchorPoint.x = (onoPoint.x + twoPoint.x) / 2 / view.bounds.size.width;
//        anchorPoint.y = (onoPoint.y + twoPoint.y) / 2 / view.bounds.size.height;
//        [Tools setAnchorPoint:anchorPoint forView:view];
//    }
//    if (pinchGestureRecognizer.state == UIGestureRecognizerStateFailed||pinchGestureRecognizer.state == UIGestureRecognizerStateEnded) {
//        [Tools setDefaultAnchorPointforView:view];
//    }
    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        float factor = pinchGestureRecognizer.scale;
        self.headerImageView.transform = CGAffineTransformScale(self.headerImageView.transform, factor, factor);
        pinchGestureRecognizer.scale =1;
    }
    
}

#pragma mark pan   平移手势事件
-(void)panView:(UIPanGestureRecognizer *)sender{
    
    CGPoint point = [sender translationInView:self.headerImageView];
    self.headerImageView.transform = CGAffineTransformTranslate(self.headerImageView.transform, point.x, point.y);
    //增量置为0
    [sender setTranslation:CGPointZero inView:sender.view];
    
}


// 允许多个手势并发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

//转为黑白颜色
-(void)switchAction:(UISwitch*)slider{
    
    UISwitch *switchButton = (UISwitch*)slider;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        //  [MobClick event:@"output_convert_color" attributes:@{@"转换颜色":@"黑白"}];

        self.headerImage = [Tools convertImageToGreyScale:self.headerImage];
    }else {
        //  [MobClick event:@"output_convert_color" attributes:@{@"转换颜色":@"彩色"}];

        if (_hasWaterMark) {
            
            self.headerImage = [UIImage addInImage:self.imgTest withModel:_model IsDoubleImage:_isDoubleWaterMark];
        }
        else{
            self.headerImage = self.imgTest;
        }
    }
    
    self.headerImageView.image = self.headerImage;
    self.scalePhoto = self.headerImage;
    self.scalePhoto = [self dealPhotoWithSlider:self.sliderValue photoQuality:self.photoQuality];
    
}

//图片尺寸拖动
-(void)saveDealPhotoAction:(UISlider*)slider{
    float factor;
    NSLog(@"%f",slider.value);
    CGRect headImageFrame = _oldFrame;
    headImageFrame.size.width *=slider.value;
    headImageFrame.size.height *=slider.value;

    if (slider.value >= self.sliderValue) {
        factor = 1 + slider.value - self.sliderValue;
    }else{
        factor = 1 - (self.sliderValue - slider.value);
    }
    self.headerImageView.frame = headImageFrame;
    self.headerImageView.center = self.mainView.center;
    self.sliderValue = slider.value;
    
//    self.headerImageView.transform = CGAffineTransformScale(self.headerImageView.transform, factor, factor);
    
//    NSData *data = UIImagePNGRepresentation(self.headerImage);

//    CGFloat length = [data length]/1000.0;
//    self.photoLengthLabel.text = [NSString stringWithFormat:@"%.0fKB",length];
    
    CGFloat width = self.headerImage.size.width;
    CGFloat height = self.headerImage.size.height;
    NSString * widthStr = [NSString stringWithFormat:@"%.f",width * self.sliderValue];
    NSString * heightStr = [NSString stringWithFormat:@"%.f",height * self.sliderValue];
    self.leftTF.text = widthStr;
    self.rightTF.text = heightStr;
//    _leftTF.text = [NSString stringWithFormat:@"%.0f",self.headerImage.size.width *slider.value];
//    _rightTF.text = [NSString stringWithFormat:@"%.0f",self.headerImage.size.height* slider.value];
    self.scalePhoto = [self dealPhotoWithSlider:self.sliderValue photoQuality:self.photoQuality];
    
}

-(void)changePhotoQuality:(UIButton*)sender{
    if(self.savePhotoQualitySelectedButton == sender) {
        //上次点击过的按钮，不做处理
    } else{
        //本次点击的按钮设为蓝色
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor colorWithHexString:@"0473F5"];
        //将上次点击过的按钮设为白色
        [self.savePhotoQualitySelectedButton setTitleColor:[UIColor colorWithHexString:@"0473F5"] forState:UIControlStateNormal];
        self.savePhotoQualitySelectedButton.backgroundColor = [UIColor whiteColor];
    }
    self.savePhotoQualitySelectedButton= sender;
    
    switch (sender.tag - 60) {
        case 0:
        {
            self.photoQuality = 0.3;
            self.scalePhoto = [self dealPhotoWithSlider:self.sliderValue photoQuality:self.photoQuality];
            //  [MobClick event:@"output_quality" attributes:@{@"图片质量":@"低"}];
        }
            break;
        case 1:
        {
            self.photoQuality = 0.6;
            self.scalePhoto = [self dealPhotoWithSlider:self.sliderValue photoQuality:self.photoQuality];
            //  [MobClick event:@"output_quality" attributes:@{@"图片质量":@"中"}];
        }
            break;
        case 2:
        {
            self.photoQuality = 0.9;
            self.scalePhoto = [self dealPhotoWithSlider:self.sliderValue photoQuality:self.photoQuality];
            //  [MobClick event:@"output_quality" attributes:@{@"图片质量":@"高"}];
        }
            break;
        case 3:
        {
            self.photoQuality = 1;
            self.sliderValue = 1;
            self.saveDealPhotoSlider.value = 1;
            self.scalePhoto = [self dealPhotoWithSlider:self.sliderValue photoQuality:self.photoQuality];
            //  [MobClick event:@"output_quality" attributes:@{@"图片质量":@"原图"}];
        }
            break;
        default:
            break;
    }
}

-(UIImage *)dealPhotoWithSlider:(CGFloat)sliderValue photoQuality:(CGFloat)qulaity{
    
    NSData * imageData = UIImageJPEGRepresentation(self.headerImage,1);
    UIImage* image = [UIImage imageWithData:imageData scale:qulaity];
    UIGraphicsBeginImageContext(CGSizeMake(self.headerImage.size.width * sliderValue, self.headerImage.size.height * sliderValue));
    [image drawInRect:CGRectMake(0, 0,self.headerImage.size.width * sliderValue,
                                 self.headerImage.size.height * sliderValue)];
    UIImage* scaledImage =
    UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    NSData * data = UIImageJPEGRepresentation(scaledImage,qulaity);
    CGFloat length = [data length]/1024.0;
    self.photoLengthLabel.text = [NSString stringWithFormat:@"%.0fKB",length];
    //  [MobClick event:@"output_size" attributes:@{@"图片大小":self.photoLengthLabel.text}];
    _leftTF.text = [NSString stringWithFormat:@"%.0f",_headerImage.size.width* sliderValue];
    _rightTF.text = [NSString stringWithFormat:@"%.0f",_headerImage.size.height* sliderValue];
    
    return scaledImage;
    
}

//保存水印图片
-(void)savePhoto{
    
    //  [MobClick event:@"output_save"];
    WeakSelf;
    if (IOS9_OR_LATER) {
        [Tools acquirePhotoAuth:^(BOOL grant) {
            if (!grant) {
                [KVNProgress showErrorWithStatus:@"您未允许访问相册,请进行设置"];
            }
            else{
                NSData * imageData = UIImageJPEGRepresentation(self.scalePhoto,self.photoQuality);

//                NSLog(@"===%f",[imageData length]/1024.0);
                //                // 获取Document目录
//                NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//                NSString *dataPath = [docPath stringByAppendingPathComponent:@"data.jpg"];
//                [imageData writeToFile:dataPath atomically:YES];
                
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//                    [PHAssetCreationRequest creationRequestForAssetFromImageAtFileURL:[NSURL fileURLWithPath:dataPath]];
                    [[PHAssetCreationRequest creationRequestForAsset] addResourceWithType:PHAssetResourceTypePhoto data:imageData options:nil];
                    
                }completionHandler:^( BOOL success, NSError *error ) {
                    if ( ! success ) {
                        [KVNProgress showErrorWithStatus:@"保存失败"];
                    }else{
                        NSLog( @"成功");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            SaveSuccess1ViewController *vc =[[SaveSuccess1ViewController alloc]init];
                            [weakSelf.navigationController pushViewController:vc animated:YES];
                        });
                    }
                }];
            }
        }];

    }
    else{
        UIImageWriteToSavedPhotosAlbum(self.scalePhoto, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }
    
}

//图片保存完的结果
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [Tools acquirePhotoAuth:^(BOOL grant) {
           
            if (!grant) {
                [KVNProgress showErrorWithStatus:@"您未允许访问相册,请进行设置"];
            }
            else{
                [KVNProgress showErrorWithStatus:@"保存失败"];
            }
            
        }];
    }
    else{
        //成功
        SaveSuccess1ViewController *vc =[[SaveSuccess1ViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
