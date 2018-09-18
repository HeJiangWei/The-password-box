//
//  DoubleImageOfSelectPhotoViewController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DoubleImageOfSelectPhotoViewController.h"
#import "ImageShowView.h"
#import "WatermarkContent1ViewController.h"
#import "OutputSeting1ViewController.h"
#import "OneCertificateViewController.h"
#import "Tools.h"
#import <UIView+Toast.h>
#import "EnlargeButton.h"
#import "PhotoShowViewController.h"
@interface DoubleImageOfSelectPhotoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>
{
    CGFloat _spaceWithCutRect;
    CGRect _waterMarkViewRect;
}

@property(nonatomic,strong)UIRotationGestureRecognizer *rotaitonGest;//旋转手势
@property(nonatomic,strong)UIPinchGestureRecognizer *pinchGest;//捏合手势
@property(nonatomic,strong)UIPanGestureRecognizer *panGest;//拖拽手势

@property(nonatomic,strong)UIView* showGrayView;//显示选中灰色图层
@property(nonatomic,strong)UIView* secondShowGrayView;//显示选中灰色图层

@property(nonatomic,strong)EnlargeButton* backTopButton;//删除按钮
@property(nonatomic,strong)EnlargeButton* backSecondButton;//删除按钮

//@property(nonatomic,strong)UIView* showTopSelectPhotoView;//选择相册
//@property(nonatomic,strong)UIView* showSecondSelectPhotoView;//选择相册


@property(nonatomic,strong)ImageShowView *topShowView;
@property(nonatomic,strong)ImageShowView *secondShowView;
//@property(nonatomic,strong)UIView *waterMarkVeiw;//装水印
//@property(nonatomic,strong)UIImageView *waterMarkImageVeiw;//显示水印
@property(nonatomic,strong)UIView* bgView;//背景视图
@property(nonatomic,strong)UIView *bottomView;//下一步视图
//@property(nonatomic,strong)UIButton *deleteBtn;//删除按钮
//@property(nonatomic,strong)UIButton *nextBtn;//下一步按钮
//@property(nonatomic,strong)UIButton *cropBtn;//裁剪按钮

@property (nonatomic, strong) UIImagePickerController *imgPicker;

@property(nonatomic,strong)ImageShowView *currentSelectImageScrollView;
@property(nonatomic,assign)BOOL isTopArea;//是否点击的是上面的那个
@property(nonatomic,assign)BOOL hasClickArea;//是否点击选择了一个面,没有的话,不能进行相册的选取操作

@end

@implementation DoubleImageOfSelectPhotoViewController


//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    if (_waterMarkVeiw!=nil) {
//        NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:kWaterMarkModel];
//
//        WaterMarkMode*model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
//
//        CGPoint point = model.doublePhotoWaterMarkPoint.CGPointValue;
//        CGRect rect = _waterMarkImageVeiw.frame;
//        rect.origin = point;

//        _waterMarkImageVeiw.image = [UIImage waterMarkImageSize:CGSizeMake(_waterMarkVeiw.frame.size.width*kwaterMarkFrameMultiple, _waterMarkVeiw.frame.size.height*kwaterMarkFrameMultiple)];
//        _waterMarkImageVeiw.frame = rect;
//        _waterMarkViewRect = _waterMarkImageVeiw.frame;

//    }
//
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"图片处理";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#4A4A4A"];
    PhotoShowViewController *vc = [[PhotoShowViewController alloc]init];
    vc.isSelectTwo = YES;
    vc.selectBlock = ^(NSMutableArray *imageArr) {
        [Tools showGessTipView];

        //        DoubleImageOfSelectPhotoViewController *vc = [[DoubleImageOfSelectPhotoViewController alloc]init];
        self.imageArr = imageArr;
        _topShowView.image = _imageArr[0];
        _secondShowView.image = _imageArr[1];
        //        [self.navigationController pushViewController:vc animated:true];
    };
    [self.navigationController pushViewController:vc animated:NO];

    [self initView];
    [self rightButtonImage:nil RightButtonTitle:@"下一步" rightButtonTarget:self rightButtonAction:@selector(nextAction)];

}


-(void)viewDidLayoutSubviews{
    
    CGFloat height =0;
    CGFloat leftSpace = 15;
    CGFloat Space = 16;
    CGFloat width = 0;
    
    height = (_bgView.bounds.size.height-3*16)/2.0;
    NSLog(@"背景的==%@",NSStringFromCGRect(_bgView.frame));
    //这样算出来的高大于屏幕的高,那么就要按照屏幕的高来算框的宽
    if ((kScreenWidth-2*leftSpace)*54/85.6*2>_bgView.bounds.size.height) {
        
        height = (_bgView.bounds.size.height-3*Space)/2.0;
        width = height*85.6/54;
        if (width+2*leftSpace>kScreenWidth) {
            width = (kScreenWidth-2*leftSpace);
            height = width*54/85.6;
            Space = (_bgView.bounds.size.height-2*height)/3.0;
        }
        leftSpace = (kScreenWidth-width)/2.0;
        
    }else{
        //屏幕的高不大于
        height = (_bgView.bounds.size.height-3*Space)/2.0;
        width = height*85.6/54;
        if (width+2*leftSpace>kScreenWidth) {
            width = kScreenWidth - 2*leftSpace;
            height = width*54/85.6;
            Space = (_bgView.bounds.size.height-2*height)/3.0;
        }
        leftSpace = (kScreenWidth-width)/2.0;
    }
//    _topShowView.frame = CGRectMake(leftSpace, Space, width, height);
    [_topShowView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(Space);
        make.left.mas_equalTo(self.view).mas_offset(leftSpace);
        make.width.mas_offset(width);
        make.height.mas_offset(height);
    }];
    [_secondShowView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topShowView.mas_bottom).mas_offset(Space);
        make.left.mas_equalTo(self.view).mas_offset(leftSpace);
        make.width.mas_offset(width);
        make.height.mas_offset(height);
    }];

    _spaceWithCutRect = Space;
    
}

/*
 *   初始化界面
 */
-(void)initView{
    
    [self loadBottomView];
    
    _bgView  = [[UIView alloc]init];
    _bgView.backgroundColor = [UIColor colorWithHexString:@"fafafa"];
    [self.view addSubview:_bgView];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.mas_equalTo(self.view).mas_offset(0);
        make.bottom.mas_equalTo(_bottomView.mas_top).mas_offset(0);
        
    }];
    WeakSelf;
    if (!_topShowView) {
        _topShowView = [[ImageShowView alloc]initWithFrame:CGRectZero andTakePhoto:NO andSelectBlock:^(ImageShowView *imageScrollView) {
            _isTopArea = YES;
            _hasClickArea = YES;
            [self setGrayView:_isTopArea];
        }];
        ViewBorderRadius(_topShowView, 0, 1, [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1]);
        _topShowView.backgroundColor = [UIColor whiteColor];
        _topShowView.userInteractionEnabled = YES;
        _topShowView.isTop = YES;

        _topShowView.image = _imageArr[0];
        [self.view addSubview:_topShowView];
        [_topShowView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.top.bottom.mas_equalTo(self.view).mas_offset(0);
            
        }];
    }
    if (!_secondShowView) {
        _secondShowView = [[ImageShowView alloc]initWithFrame:CGRectZero andTakePhoto:NO andSelectBlock:^(ImageShowView *imageScrollView) {
            _isTopArea = NO;
            _hasClickArea = YES;
            [self setGrayView:_isTopArea];
        }];

        ViewBorderRadius(_secondShowView, 0, 1, [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1]);
        _secondShowView.backgroundColor = [UIColor whiteColor];
        _secondShowView.userInteractionEnabled = YES;
        _secondShowView.isTop = NO;
        _secondShowView.image = _imageArr[1];
        [self.view addSubview:_secondShowView];

        [_secondShowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self.view).mas_offset(0);
            
        }];

    }
    
}

- (void)loadBottomView {
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectZero];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        make.height.mas_offset(50);
        make.bottom.mas_equalTo(IOS11_OR_LATER?self.view.mas_safeAreaLayoutGuideBottom:self.view.mas_bottom).mas_offset(0);
        
    }];
    
    UIButton *setMarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setMarkBtn.frame = CGRectMake(10, 7, 100, 30);
    setMarkBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [setMarkBtn setImage:[UIImage imageNamed:@"xiangce"] forState:UIControlStateNormal];
    [setMarkBtn setTitle:@"相册" forState:UIControlStateNormal];
    [setMarkBtn setTitleColor:[UIColor colorWithHexString:@"a0a0a2"] forState:UIControlStateNormal];
    setMarkBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [setMarkBtn addTarget:self action:@selector(handleImageAction) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:setMarkBtn];
    
}

/*
 *  选取相片
 */
-(void)handleImageAction{
    if (!_hasClickArea) {
        [self.view makeToast:@"请选择一面"];

        return;
    }
    
    PhotoShowViewController *vc = [[PhotoShowViewController alloc]init];
    vc.isNomalPush = YES;
    vc.selectBlock = ^(NSMutableArray *imageArr) {
      
        for (UIImage *result in imageArr) {
            if (_isTopArea) {
                _topShowView.backTopButton.hidden = YES;
                _topShowView.image = result;
            }
            else{
                _secondShowView.backTopButton.hidden = YES;
                _secondShowView.image  = result;
            }
        }
    };
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)pinView:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    if (pinchGestureRecognizer.numberOfTouches<2) {
        return;
    }
    CGPoint onoPoint = [pinchGestureRecognizer locationOfTouch:0 inView:self.view];
    CGPoint twoPoint = [pinchGestureRecognizer locationOfTouch:1 inView:self.view];
    UIView *view ;
    
    if (CGRectContainsPoint(_topShowView.frame, onoPoint)&&CGRectContainsPoint(_topShowView.frame, twoPoint)) {
        view = _topShowView.imageView;
    }
    else if(CGRectContainsPoint(_secondShowView.frame, onoPoint)&&CGRectContainsPoint(_secondShowView.frame, twoPoint)){
        view = _secondShowView.imageView;
    }
    else{
        return;
    }
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        if ([view  isEqual:_topShowView.imageView]) {
            NSLog(@"----------上面上面-----------");
            
            //  [MobClick event:@"album_double_move_photo_a" attributes:@{@"相册双面上":@"放大缩小"}];
        }
        else{
            NSLog(@"----------下面下面-----------");
            
            //  [MobClick event:@"album_double_move_photo_b" attributes:@{@"相册双面下":@"放大缩小"}];
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
    if (CGRectContainsPoint(_topShowView.frame, onoPoint)&&CGRectContainsPoint(_topShowView.frame, twoPoint)) {
        view = _topShowView.imageView;
        
    }
    else if(CGRectContainsPoint(_secondShowView.frame, onoPoint)&&CGRectContainsPoint(_secondShowView.frame, twoPoint)){
        view = _secondShowView.imageView;
    }
    else{
        return;
    }
    
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        if ([view  isEqual:_topShowView.imageView]) {
            NSLog(@"----------上面上面-----------");
            
            //  [MobClick event:@"album_double_move_photo_a" attributes:@{@"相册双面上":@"旋转"}];
        }
        else{
            NSLog(@"----------下面下面-----------");
            
            //  [MobClick event:@"album_double_move_photo_b" attributes:@{@"相册双面下":@"旋转"}];
            
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
 *  下一步按钮事件
 */
-(void)nextAction{
    
//    if (_topShowView.isSetImage&&_secondShowView.isSetImage) {
        //  [MobClick event:@"album_double_next"];
//        NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:kWaterMarkModel];
//
//        WaterMarkMode*model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
//
//        model.doublePhotoWaterMarkPoint = [NSValue valueWithCGPoint:_waterMarkViewRect.origin];
//
//        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:model];
//        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kWaterMarkModel];
//        [[NSUserDefaults standardUserDefaults] synchronize];

    BOOL showTopreturnBtn = NO;
    if (!_topShowView.backTopButton.hidden) {
        _topShowView.backTopButton.hidden = YES;
        showTopreturnBtn = YES;
    }
    _topShowView.layer.borderColor = [UIColor whiteColor].CGColor;
    UIImage *image = [Tools imageFromView:_topShowView];
    ViewBorderRadius(_topShowView, 0, 1, [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1]);

    if (showTopreturnBtn) {
        _topShowView.backTopButton.hidden = NO;
    }
    BOOL showsecondreturnBtn = NO;
    if (!_secondShowView.backTopButton.hidden) {
        _secondShowView.backTopButton.hidden = YES;
        showsecondreturnBtn = YES;
    }
    _secondShowView.layer.borderColor = [UIColor whiteColor].CGColor;
    UIImage *images = [Tools imageFromView:_secondShowView];
    ViewBorderRadius(_secondShowView, 0, 1, [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1]);
    if (showsecondreturnBtn) {
        _secondShowView.backTopButton.hidden = NO;
    }
    
    UIImage *finallImage = [Tools addImage:image toImage:images andSpace:_spaceWithCutRect];
    
    WatermarkContent1ViewController *vc = [[WatermarkContent1ViewController alloc]init];
    vc.headerImage = finallImage;
    vc.isDoubleWaterMark = YES;
    [self.navigationController pushViewController:vc animated:true];
    
//    }
//    else{
//
//        [self.navigationController.view makeToast:@"需两张选择完,才能下一步"];
//
//    }
    
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
//    return YES;
    
    if (([gestureRecognizer isEqual:_rotaitonGest]&&[otherGestureRecognizer isEqual:_pinchGest])||([gestureRecognizer isEqual:_pinchGest]&&[otherGestureRecognizer isEqual:_rotaitonGest])) {
        NSLog(@"拖动和旋转");
        return YES;
    }
    
    return NO;

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
        _showGrayView = [[UIView alloc]initWithFrame:_topShowView.frame];
        _showGrayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self.view addSubview:_showGrayView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectToptapAction)];
        [_showGrayView addGestureRecognizer:tap];
    }
    return _showGrayView;
}
-(UIView *)secondShowGrayView{
    if (_secondShowGrayView==nil) {
        _secondShowGrayView = [[UIView alloc]initWithFrame:_secondShowView.frame];
        _secondShowGrayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self.view addSubview:_secondShowGrayView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectSecondtapAction)];
        [_secondShowGrayView addGestureRecognizer:tap];
    }
    return _secondShowGrayView;
}

/*
 *  点击手势作用与上面的选择相册
 */
-(void)selectToptapAction{
//    //  [MobClick event:@"album_double_take_photo_a"];
//    _isTopArea = YES;
//    _currentSelectImageScrollView = _topShowView;
    _isTopArea = YES;
    self.showGrayView.hidden = YES;
    self.secondShowGrayView.hidden = NO;
    
}

/*
 *  点击手势作用与下面的选择相册
 */
-(void)selectSecondtapAction{
//    //  [MobClick event:@"album_double_take_photo_b"];
//
//    _isTopArea = NO;
//    _currentSelectImageScrollView = _secondShowView;
////    [self openPhoto];
//
////    [_showSecondSelectPhotoView removeFromSuperview];
////    [_deleteBtn setImage:[UIImage imageNamed:@"删除照片"] forState:UIControlStateNormal];
    _isTopArea = NO;
    self.showGrayView.hidden = NO;
    self.secondShowGrayView.hidden = YES;
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

