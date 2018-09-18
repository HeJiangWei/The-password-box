//
//  OneImageOfSelectPhotoViewController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on 2017/12/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OneImageOfSelectPhotoViewController.h"
#import "ImageShowView.h"
#import "ClipViewController.h"
#import "Tools.h"
#import <UIView+Toast.h>
#import "PopGessture1Tip.h"
#import "DoubleImageOfSelectPhotoViewController.h"

@interface OneImageOfSelectPhotoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIView* showGrayView;//显示选中灰色图层
@property(nonatomic,strong)UIView* showTopSelectPhotoView;//选择相册
@property(nonatomic,strong)ImageShowView *topShowView;
@property(nonatomic,strong)UIImageView *waterMarkVeiw;//显示水印预览层
@property(nonatomic,strong)UIView *bottomView;//下一步视图
@property(nonatomic,strong)UIButton *deleteBtn;//删除按钮
@property(nonatomic,strong)UIButton *nextBtn;//下一步按钮

@property (nonatomic, strong) UIImagePickerController *imgPicker;
@property(nonatomic,strong)ImageShowView *currentSelectImageScrollView;

@end

@implementation OneImageOfSelectPhotoViewController

//安全区域改变了
-(void)viewSafeAreaInsetsDidChange{
    
    [super viewSafeAreaInsetsDidChange];
    NSLog(@"安全区域改变了");
    [self initView:self.view.safeAreaInsets];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_waterMarkVeiw!=nil) {
        _waterMarkVeiw.image = [UIImage waterMarkImageSize:_waterMarkVeiw.frame.size];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#4A4A4A"];
//    [self rightButtonImage:nil RightButtonTitle:@"下一步" rightButtonTarget:self rightButtonAction:@selector(nextAction)];
    [self rightButtonImage:nil RightButtonTitle:@"" rightButtonTarget:self rightButtonAction:nil];
    
    if (IOS11_OR_LATER) {
        //ios11以上的系统调用的是上面的那个方法
    }
    else{
        [self initView:UIEdgeInsetsZero];
    }
}

/*
 *   初始化界面
 */
-(void)initView:(UIEdgeInsets)inset{
    
    CGFloat top = 0;
    if (inset.top==0) {
        top = 64;
    }
    else{
        top = inset.top;
    }
    CGFloat height = kScreenHeight - inset.bottom-80-top - 40;
    CGFloat width = height*210/297.0;
    if (width>=kScreenWidth) {
        width = kScreenWidth-40;
        height = 297*width/210.0;
    }
    
    _topShowView = [[ImageShowView alloc]initWithFrame:CGRectMake((kScreenWidth-width)/2.0, top+(kScreenHeight-top-80-inset.bottom-height)/2.0, width, height) andTakePhoto:NO andSelectBlock:^(ImageShowView *imageScrollView) {
    }];
    ViewBorderRadius(_topShowView, 0, 1, [UIColor whiteColor]);
    _topShowView.backgroundColor = [UIColor whiteColor];
//    [_topShowView setshowLabel];
    [self.view addSubview:_topShowView];
    
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-80-inset.bottom, kScreenWidth, 80)];
    _bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bottomView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, _bottomView.frame.size.width-20, _bottomView.frame.size.height)];
    imageView.image = [UIImage imageNamed:@"Rectangle"];
    imageView.userInteractionEnabled = YES;
    [_bottomView addSubview:imageView];
    
//    UIButton * gotoDoubleImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    gotoDoubleImageButton.frame = CGRectMake(0, 9, 60, 60);
//    [gotoDoubleImageButton setImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
//    [gotoDoubleImageButton addTarget:self action:@selector(gotoDoubleImageFromSelectPhoto) forControlEvents:UIControlEventTouchUpInside];
//    [imageView addSubview:gotoDoubleImageButton];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.frame = CGRectMake((imageView.frame.size.width-60)/2.0, 9, 60, 60);
    [_deleteBtn setImage:[UIImage imageNamed:@"删除照片"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:_deleteBtn];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(imageView.frame.size.width-63, 17, 50, 50);
    [_nextBtn setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
    [_nextBtn setImage:[UIImage imageNamed:@"8"] forState:UIControlStateSelected];
    [_nextBtn addTarget:self action:@selector(clearWaterMark:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:_nextBtn];
    
    [self setTopSelectPhotoView];
}

-(void)openPhoto{
    
    [self openImagePickerControllerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    
}

/// 打开ImagePickerController的方法
- (void)openImagePickerControllerWithType:(UIImagePickerControllerSourceType)type
{
    
    // 设备不可用  直接返回
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    _imgPicker = [[UIImagePickerController alloc] init];
    _imgPicker.sourceType = type;
    _imgPicker.delegate = self;
    _imgPicker.allowsEditing = NO;
    [self presentViewController:_imgPicker animated:YES completion:nil];
    
}

#pragma mark - UINavigationControllerDelegate, UIImagePickerControllerDelegate
// 选择照片之后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    [_topShowView.showLabel removeFromSuperview];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _currentSelectImageScrollView.isSetImage = YES;
    _currentSelectImageScrollView.image = image;
    [_deleteBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [_imgPicker dismissViewControllerAnimated:NO completion:nil];
    [Tools showGessTipView];
//    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7.0/*延迟执行时间*/ * NSEC_PER_SEC));
//    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//        [Tools showAleartView];
//    });
    
    ClipViewController *vc = [[ClipViewController alloc]init];
    vc.image = image;
    [self.navigationController pushViewController:vc animated:NO];

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"取消选择");
    
    [_imgPicker dismissViewControllerAnimated:YES completion:nil];
    _topShowView.isSetImage = NO;
    _topShowView.image = nil;
    [self setTopSelectPhotoView];
//    [_topShowView setshowLabel];
}

/*
 *  删除按钮事件
 */
-(void)deleteAction{

    [_showGrayView removeFromSuperview];
    _topShowView.pinchGest.enabled = YES;
    _topShowView.rotaitonGest.enabled = YES;
    _topShowView.panGest.enabled = YES;
    
    [_deleteBtn setImage:[UIImage imageNamed:@"删除照片"] forState:UIControlStateNormal];
    _topShowView.isSetImage = NO;
    _topShowView.image = nil;
    [self setTopSelectPhotoView];
//    [_topShowView setshowLabel];
}

/*
 *  跳转到双面选择按钮事件
 */
//-(void)gotoDoubleImageFromSelectPhoto{
//    if (self.isPush) {
//        [self.navigationController popViewControllerAnimated:NO];
//    }else{
//        DoubleImageOfSelectPhotoViewController * vc = [[DoubleImageOfSelectPhotoViewController alloc]init];
//        vc.isPush = YES;
//        [self.navigationController pushViewController:vc animated:NO];
//    }

//}

/*
 *  添加水印
 */
-(void)clearWaterMark:(UIButton*)btn{
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        _waterMarkVeiw = [[UIImageView alloc]initWithFrame:CGRectMake(_topShowView.frame.origin.x, _topShowView.frame.origin.y, _topShowView.frame.size.width, _topShowView.frame.size.height)];
        [self.view addSubview:_waterMarkVeiw];
        
        _waterMarkVeiw.image = [UIImage waterMarkImageSize:_waterMarkVeiw.frame.size];
        [self.view insertSubview:_waterMarkVeiw atIndex:2];
    }
    else{
        [_waterMarkVeiw removeFromSuperview];
    }
    
}

/*
 *  下一步按钮事件
 */
//-(void)nextAction{
//
//    if (_topShowView.isSetImage) {
//        _topShowView.showLabel.hidden = YES;
//
//        UIImage *image = [Tools imageFromView:_topShowView];
//        image = [Tools imageFromImage:image atFrame:_topShowView.frame];
//
//        ClipViewController *vc = [[ClipViewController alloc]init];
//        vc.image = image;
//        [self.navigationController pushViewController:vc animated:true];
//    }
//    else{
//        [self.navigationController.view makeToast:@"需选择完,才能下一步"];
//
//    }
//
//}

//显示灰色视图
//是否是上层
-(void)setGrayView:(BOOL)istop{
    
    [_showGrayView removeFromSuperview];
    _showGrayView = [[UIView alloc]initWithFrame:_topShowView.frame];
    _showGrayView.backgroundColor = [UIColor lightGrayColor];
    _showGrayView.alpha = 0.8;
    [self.view addSubview:_showGrayView];
    _showGrayView.userInteractionEnabled = YES;
    
}

//显示选择相册的视图
-(void)setTopSelectPhotoView{
    
    [_showTopSelectPhotoView removeFromSuperview];
    _showTopSelectPhotoView = [[UIView alloc]initWithFrame:_topShowView.frame];
    _showTopSelectPhotoView.backgroundColor = [UIColor clearColor];
    UIView *colorview = [[UIView alloc]initWithFrame:_showTopSelectPhotoView.bounds];
    colorview.backgroundColor = [UIColor lightGrayColor];
    colorview.alpha = 0.8;
    [_showTopSelectPhotoView addSubview:colorview];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((_showTopSelectPhotoView.bounds.size.width-60)/2.0,(_showTopSelectPhotoView.bounds.size.height-60)/2.0, 60, 60)];
    //    imageView.center = _showTopSelectPhotoView.center;
    imageView.image = [UIImage imageNamed:@"相册导入"];
    imageView.userInteractionEnabled = YES;
    [_showTopSelectPhotoView addSubview:imageView];
    _showTopSelectPhotoView.userInteractionEnabled = YES;
    [self.view addSubview:_showTopSelectPhotoView];
    
    UITapGestureRecognizer*selectToptap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectToptapAction)];
    [_showTopSelectPhotoView addGestureRecognizer:selectToptap];
    
}

/*
 *  点击手势作用与上面的选择相册
 */
-(void)selectToptapAction{
    _currentSelectImageScrollView = _topShowView;
    
    [self openPhoto];
    [_showTopSelectPhotoView removeFromSuperview];
    [_deleteBtn setImage:[UIImage imageNamed:@"删除照片"] forState:UIControlStateNormal];
    
}

@end
