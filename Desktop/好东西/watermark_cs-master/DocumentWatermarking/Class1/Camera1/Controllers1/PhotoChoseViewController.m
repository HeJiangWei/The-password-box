//
//  PhotoChoseViewController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PhotoChoseViewController.h"
#import "ClipViewController.h"
#import "UIColor+16.h"
#import "DoubleImageOfSelectPhotoViewController.h"
#import "OneImageOfSelectPhotoViewController.h"
#import "WatermarkContent1ViewController.h"
#import "PhotoShowViewController.h"
#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height

@interface PhotoChoseViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIImagePickerController *imgPicker;

@end

@implementation PhotoChoseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"从相册导入";
    [self creatUI];
    
}

-(void)creatUI{
    
    UIImageView * backimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    backimageView.image = [UIImage imageNamed:@"相册选择背景"];
    [self.view addSubview:backimageView];
    
    //单面
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(25, 87, KWIDTH - 50, (KWIDTH - 50)/327 * 177)];
    ViewRadius(view1, 15);
    view1.userInteractionEnabled = NO;
    [self.view addSubview:view1];
    
    UIImageView * oneImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view1.frame.size.width, view1.frame.size.height)];
    oneImage.image = [UIImage imageNamed:@"单面"];
    [view1 addSubview:oneImage];
    
    UIButton * onePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    onePhotoButton.frame = view1.frame;
    onePhotoButton.backgroundColor = [UIColor clearColor];
    [onePhotoButton addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:onePhotoButton];
    
    //双面
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(25, 87 + (KWIDTH - 50)/327 * 177 + 53 , KWIDTH - 50, (KWIDTH - 50)/327 * 177)];
    ViewRadius(view2, 15);
    view2.userInteractionEnabled = YES;
    [self.view addSubview:view2];
    
    UIImageView * twoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view2.frame.size.width, view2.frame.size.height )];
    twoImage.image = [UIImage imageNamed:@"双面(尽情期待)"];
    [view2 addSubview:twoImage];
    
//    UIButton * twoPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    twoPhotoButton.frame = view2.frame;
//    twoPhotoButton.backgroundColor = [UIColor clearColor];
//    [twoPhotoButton addTarget:self action:@selector(selectTwoPic) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:twoPhotoButton];
}

-(void)openPhoto{
    
//    //  [MobClick event:@"album_single_entry"];//[相册 单面]
//    //  [MobClick event:@"album_single_entry"];//[相册 单面]
//
//    NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:kWaterMarkModel];
//    WaterMarkMode*model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
//
//    if (model==nil||!model.isSetWaterMark) {
//        if (IOS11_OR_LATER) {
//            [self initOneView:self.view.safeAreaInsets];
//        }
//        else{
//            [self initOneView:UIEdgeInsetsZero];
//        }
//
//    }else{
    
        [Tools acquirePhotoAuth:^(BOOL grant) {
            if (grant) {
                ClipViewController *viewController = [[ClipViewController alloc] init];
//                viewController.image = result;
                [self.navigationController pushViewController:viewController animated:NO];

//                PhotoShowViewController *vc = [[PhotoShowViewController alloc]init];
//                vc.selectBlock = ^(NSMutableArray *imageArr) {
//                    for (UIImage *result in imageArr) {
//                        ClipViewController *viewController = [[ClipViewController alloc] init];
//                        viewController.image = result;
//                        [self.navigationController pushViewController:viewController animated:NO];
//                    }
//                };
//                [self.navigationController pushViewController:vc animated:NO];
                
//                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                imagePicker.sourceType = sourceType;
//                imagePicker.delegate = self;
//                [self presentViewController: imagePicker animated:YES completion: NULL];

            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"获取授权" message:@"您已设置关闭使用相册,请在设备的设置-隐私-相册中允许使用。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定" ,nil];
                [alertView show];

            }
            
        }];
        
//    }
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

#pragma mark - UINavigationControllerDelegate, UIImagePickerControllerDelegate
// 选择照片之后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated: NO completion: NULL];
    
    [self cropImage:image];
    
}

- (void)cropImage: (UIImage *)image {
    ClipViewController *viewController = [[ClipViewController alloc] init];
    viewController.image = image;
    [self.navigationController pushViewController:viewController animated:NO];
//     [self presentViewController:viewController animated:NO completion:nil];
}


/*
 *  selectTwoPic
 */
-(void)selectTwoPic{
//    //  [MobClick event:@"album_double_entry"];//[相册 双面]
    
//    NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:kWaterMarkModel];
//    WaterMarkMode*model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
//
//    if (model==nil||!model.isSetWaterMark) {
//        if (IOS11_OR_LATER) {
//            [self initView:self.view.safeAreaInsets];
//        }
//        else{
//            [self initView:UIEdgeInsetsZero];
//        }
//    }else{
    
    [Tools acquirePhotoAuth:^(BOOL grant) {
        if (grant) {
            DoubleImageOfSelectPhotoViewController *vc = [[DoubleImageOfSelectPhotoViewController alloc]init];
//            vc.imageArr = imageArr;
            [self.navigationController pushViewController:vc animated:NO];

//            PhotoShowViewController *vc = [[PhotoShowViewController alloc]init];
//            vc.isSelectTwo = YES;
//            vc.selectBlock = ^(NSMutableArray *imageArr) {
//                DoubleImageOfSelectPhotoViewController *vc = [[DoubleImageOfSelectPhotoViewController alloc]init];
//                vc.imageArr = imageArr;
//                [self.navigationController pushViewController:vc animated:true];
//            };
//            [self.navigationController pushViewController:vc animated:NO];
            
            //                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            //                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //                imagePicker.sourceType = sourceType;
            //                imagePicker.delegate = self;
            //                [self presentViewController: imagePicker animated:YES completion: NULL];
            
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"获取授权" message:@"您已设置关闭使用相册,请在设备的设置-隐私-相册中允许使用。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定" ,nil];
            [alertView show];
            
        }
        
    }];

//    }
    
}

///*
// *   初始化界面
// */
///*
// *   初始化界面
// */
//-(void)initOneView:(UIEdgeInsets)inset{
//    CGFloat top = 0;
//    if (inset.top==0) {
//        top = 64;
//    }
//    else{
//        top = inset.top;
//    }
//    CGFloat height = kScreenHeight - inset.bottom-80-top - 40;
//    CGFloat width = height*210/297.0;
//    if (width>=kScreenWidth) {
//        width = kScreenWidth-40;
//        height = 297*width/210.0;
//    }
//
//    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-width)/2.0, top+(kScreenHeight-top-80-inset.bottom-height)/2.0, width, height)];
//    bgImageView.image = [UIImage imageNamed:@"相册选择单面"];
//    bgImageView.backgroundColor = [UIColor whiteColor];
//
//    [self.view addSubview:bgImageView];
//
//    UIImage * newsImages = [Tools imageFromView:bgImageView];
//    UIImage * image = [Tools imageFromImage:newsImages atFrame:CGRectMake(0, 0, bgImageView.frame.size.width, bgImageView.frame.size.height)];
//    [bgImageView removeFromSuperview];
//
//    WatermarkContent1ViewController *viewController = [[WatermarkContent1ViewController alloc] init];
//    viewController.headerImage = image;
//    [self.navigationController pushViewController: viewController animated: YES];
//}

//-(void)initView:(UIEdgeInsets)inset{
//    CGFloat topspace = 0;
//    CGFloat height =0;
//    CGFloat bottomSpace = 0;
//    CGFloat leftSpace = 15;
//    CGFloat Space = 16;
//    CGFloat width = 0;
//    if (inset.top==0) {
//        topspace = 64;
//        height = (kScreenHeight- 80 -topspace-3*16)/2.0;
//    }
//    else{
//        topspace = inset.top;
//        bottomSpace = inset.bottom;
//        height = (kScreenHeight- 80- bottomSpace -topspace-3*16)/2.0;
//    }
//
//    //这样算出来的高大于屏幕的高,那么就要按照屏幕的高来算框的宽
//    if ((kScreenWidth-2*leftSpace)*54/85.6*2>(kScreenHeight-bottomSpace-topspace-80)) {
//
//        height = (kScreenHeight-bottomSpace-topspace-80-3*Space)/2.0;
//        width = height*85.6/54;
//        if (width+2*leftSpace>kScreenWidth) {
//            width = (kScreenWidth-2*leftSpace);
//            height = width*54/85.6;
//            Space = (kScreenHeight-bottomSpace-topspace-80-2*height)/3.0;
//        }
//        leftSpace = (kScreenWidth-width)/2.0;
//
//    }else{
//        //屏幕的高不大于
//        height = (kScreenHeight-bottomSpace-topspace-80-3*Space)/2.0;
//        width = height*85.6/54;
//        if (width+2*leftSpace>kScreenWidth) {
//            width = kScreenWidth - 2*leftSpace;
//            height = width*54/85.6;
//            Space = (kScreenHeight-bottomSpace-topspace-80-2*height)/3.0;
//        }
//        leftSpace = (kScreenWidth-width)/2.0;
//    }
//
//    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-30, height)];
//    topImageView.image = [UIImage imageNamed:@"身份证正面"];
//
//    UIImageView *secondImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, height+Space, kScreenWidth-30, height)];
//    secondImageView.image = [UIImage imageNamed:@"身份证背面"];
//
//    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(topImageView.frame.origin.x, topImageView.frame.origin.y, topImageView.frame.size.width, topImageView.frame.size.height+secondImageView.frame.size.height+secondImageView.frame.origin.y-CGRectGetMaxY(topImageView.frame))];
//    bgImageView.backgroundColor = [UIColor whiteColor];
//    [bgImageView addSubview:topImageView];
//    [bgImageView addSubview:secondImageView];
//    [self.view addSubview:bgImageView];
//
//    UIImage * newsImages = [Tools imageFromView:bgImageView];
//    UIImage * finallImage = [Tools imageFromImage:newsImages atFrame:CGRectMake(0, 0, bgImageView.frame.size.width, bgImageView.frame.size.height)];
//    [bgImageView removeFromSuperview];
//
//    WatermarkContent1ViewController *viewController = [[WatermarkContent1ViewController alloc] init];
//    viewController.headerImage = finallImage;
//    viewController.isDoubleWaterMark = YES;
//    [self.navigationController pushViewController: viewController animated: YES];
//
//}



@end
