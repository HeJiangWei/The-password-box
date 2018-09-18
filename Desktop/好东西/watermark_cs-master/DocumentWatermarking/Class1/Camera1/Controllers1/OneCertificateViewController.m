//
//  OneCertificateViewController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on 2017/12/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OneCertificateViewController.h"
#import "ImageShowView.h"
#import "WatermarkContent1ViewController.h"
#import "Tools.h"
#import <UIView+Toast.h>
#import "PopGessture1Tip.h"

@interface OneCertificateViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UIView* showTopSelectPhotoView;//选择相册
@property(nonatomic,strong)ImageShowView *topShowView;
@property(nonatomic,strong)UIImageView *waterMarkVeiw;//显示水印

@property(nonatomic,strong)UIView *bottomView;//下一步视图
@property(nonatomic,strong)UIButton *deleteBtn;//删除按钮
@property(nonatomic,strong)UIButton *nextBtn;//下一步按钮

@property (nonatomic, strong) UIImagePickerController *imgPicker;

@end

@implementation OneCertificateViewController

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
    self.title = @"证件单面";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#4A4A4A"];
    [self rightButtonImage:nil RightButtonTitle:@"下一步" rightButtonTarget:self rightButtonAction:@selector(nextAction)];
    
    if (IOS11_OR_LATER) {
        //ios11以上的系统调用的是上面的那个方法
    }
    else{
        [self initView:UIEdgeInsetsZero];
    }

}
/*
 *  下一步时间
 */
-(void)nextAction{
    if (_topShowView.isSetImage) {
        _waterMarkVeiw.hidden = YES;
        UIImage *image = [Tools imageFromView:self.view];
        
        image = [Tools imageFromImage:image atFrame:_topShowView.frame];
        _waterMarkVeiw.hidden = NO;
        WatermarkContent1ViewController *vc = [[WatermarkContent1ViewController alloc]init];
        vc.headerImage = image;
        [self.navigationController pushViewController:vc animated:true];
        
    }
    else{
        
        [self.navigationController.view makeToast:@"需选择照片,才能下一步"];
    }

}
/*
 *   初始化界面
 */
-(void)initView:(UIEdgeInsets)inset{
    CGFloat bottomSpace = 0;
    CGFloat width = kScreenWidth-40;
    CGFloat height = width*54/85.6;
    CGFloat top = 0;
    CGFloat bottom =0;
    if (inset.top==0) {
        top = 64;
    }
    else{
        top = inset.top;
        bottomSpace = inset.bottom;
    }
    bottom = inset.bottom;
    CGRect rect = CGRectMake(20, top+(kScreenHeight-height-bottom-top-80)/2.0, width, height);

    
    if (!_topShowView) {
        
        _topShowView = [[ImageShowView alloc]initWithFrame:rect andTakePhoto:NO andSelectBlock:^(ImageShowView *imageScrollView) {
       
        }];
        ViewBorderRadius(_topShowView, 0, 1, [UIColor whiteColor]);
        _topShowView.backgroundColor = [UIColor whiteColor];
        _topShowView.userInteractionEnabled = YES;
        [self.view addSubview:_topShowView];
        [self setTopSelectPhotoView];
        
    }
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-80-bottomSpace, kScreenWidth, 80)];
        _bottomView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_bottomView];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, _bottomView.frame.size.width-20, _bottomView.frame.size.height)];
        imageView.image = [UIImage imageNamed:@"Rectangle"];
        imageView.userInteractionEnabled = YES;
        [_bottomView addSubview:imageView];
        
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(14, 13, 40, 54);
        [leftBtn setImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:leftBtn];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake((imageView.frame.size.width-60)/2.0, 9, 60, 60);
        [_deleteBtn setImage:[UIImage imageNamed:@"删除照片"] forState:UIControlStateNormal];
        
        [_deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        
        [imageView addSubview:_deleteBtn];
        
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(imageView.frame.size.width-63, 13, 40, 54);
        [_nextBtn setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
        [_nextBtn setImage:[UIImage imageNamed:@"8"] forState:UIControlStateSelected];
        
        [_nextBtn addTarget:self action:@selector(clearWaterMark:) forControlEvents:UIControlEventTouchUpInside];
        
        [imageView addSubview:_nextBtn];
        
    }
    
}

/*
 *  左边按钮事件
 */
-(void)leftAction{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

/*
 *  删除按钮事件
 */
-(void)deleteAction{
    
    _topShowView.isSetImage = NO;
    _topShowView.image = nil;
    [self setTopSelectPhotoView];
    [_deleteBtn setImage:[UIImage imageNamed:@"删除照片"] forState:UIControlStateNormal];
    
}

/*
 *  添加水印
 */
-(void)clearWaterMark:(UIButton*)btn{
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        _waterMarkVeiw = [[UIImageView alloc]initWithFrame:_topShowView.frame];
        _waterMarkVeiw.image = [UIImage waterMarkImageSize:_topShowView.frame.size];
        [self.view addSubview:_waterMarkVeiw];
        [self.view insertSubview:_waterMarkVeiw atIndex:2];
    }
    else{
        [_waterMarkVeiw removeFromSuperview];
    }

    
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
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _topShowView.isSetImage = YES;
    _topShowView.image = image;
    [_deleteBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    
    [_imgPicker dismissViewControllerAnimated:YES completion:nil];
    [Tools showGessTipView];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        if (IOS11_OR_LATER) {
            [Tools showAleartView:self.view.safeAreaInsets];
            
        }
        else{
            [Tools showAleartView:UIEdgeInsetsZero];
            
        }
    });
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"取消选择");
    //    [_currentSelectImageScrollView setSelectPhotoView];
    
    [self setTopSelectPhotoView];
    
    [_imgPicker dismissViewControllerAnimated:YES completion:nil];
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
    
    UILabel*showLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, _showTopSelectPhotoView.bounds.size.height-25, 200, 17)];
    showLabel.textColor = [UIColor whiteColor];
    showLabel.text = @"可旋转,可缩放";
    [_showTopSelectPhotoView addSubview:showLabel];
    
    [self.view addSubview:_showTopSelectPhotoView];
    
    UITapGestureRecognizer*selectToptap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectToptapAction)];
    [_showTopSelectPhotoView addGestureRecognizer:selectToptap];
    
}

/*
 *  点击手势作用与上面的选择相册
 */
-(void)selectToptapAction{
    [self openPhoto];
    [_showTopSelectPhotoView removeFromSuperview];
    [_deleteBtn setImage:[UIImage imageNamed:@"删除照片"] forState:UIControlStateNormal];
    
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
