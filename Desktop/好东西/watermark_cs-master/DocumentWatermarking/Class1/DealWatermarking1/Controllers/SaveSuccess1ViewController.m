//
//  SaveSuccess1ViewController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SaveSuccess1ViewController.h"
#import "PopShareView.h"
//#import <WXApi.h>
//#import <WeiboSDK.h>
//#import <TencentOpenAPI/QQApiInterface.h>
#import "FeatureSuggestionsViewController.h"
#import "HelpCenter1ViewController.h"
#import <KVNProgress.h>
#import "AboutUs1ViewController.h"

@interface SaveSuccess1ViewController ()

@end

@implementation SaveSuccess1ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"保存成功";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTopView:UIEdgeInsetsZero];
    [self rightButtonImage:nil RightButtonTitle:@"关闭" rightButtonTarget:self rightButtonAction:@selector(backTohome)];
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;

}


-(void)addTopView:(UIEdgeInsets)edg{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/667 * 311)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((view.bounds.size.width-130 * kScreenHeight/667)/2.0, 74 * kScreenHeight/667, 130 * kScreenHeight/667, 113 * kScreenHeight/667)];
    imageView.image = [UIImage imageNamed:@"保存图片"];
    [view addSubview:imageView];
    
    UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(0, 206 * kScreenHeight/667, view.bounds.size.width, 28)];
    label.textColor = [UIColor colorWithHexString:@"#999999"];
    label.text = @"保存成功";
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    UILabel*labels = [[UILabel alloc]initWithFrame:CGRectMake(0, 242 * kScreenHeight/667, view.bounds.size.width, 20)];
    labels.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    labels.text = @"照片已保存到您的手机相册，请查看";
    labels.font = [UIFont systemFontOfSize:14];
    labels.textAlignment = NSTextAlignmentCenter;
    [view addSubview:labels];
    [self.view addSubview:view];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake((kScreenWidth-80)/2.0,kScreenHeight/667 * 282, 80,40);
    [backBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor colorWithHexString:@"#0373F6"] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [backBtn addTarget:self action:@selector(backTohome) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake((kScreenWidth-200)/2.0,kScreenHeight/667 * 345, 200,50);
//    [btn setTitle:@"将APP推荐给好友" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:18];
//    [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
//    btn.backgroundColor = [UIColor colorWithHexString:@"#0373F6"];
//    ViewRadius(btn, 25);
//    [self.view addSubview:btn];
    
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.userInteractionEnabled = YES;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        make.height.mas_offset(60);
        if (IOS11_OR_LATER) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(0);
        }
        else{
            make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(0);
        }
    }];
    
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
//    line.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
//    [bottomView addSubview:line];
//
//    NSArray * btnTitleArr = @[@" 帮助中心",@" 意见反馈",@" 关于我们"];
//    NSArray * btnImageArr = @[@"帮助中心",@"意见",@"关于我们"];
//    for (int i =0; i<btnTitleArr.count; i++) {
//        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(kScreenWidth/3*i, 0, kScreenWidth/3, 60);
//        [btn setTitle:btnTitleArr[i] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:btnImageArr[i]] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:14];
//        btn.tag = 1100+i;
//        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
//        [bottomView addSubview:btn];
//    }
    
//    UIView *helperBtnView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, 80 , 80)];
//    helperBtnView.userInteractionEnabled = YES;
//    UIControl *helperControl = [[UIControl alloc]initWithFrame:helperBtnView.bounds];
//    [helperControl addTarget:self action:@selector(helperAction) forControlEvents:UIControlEventTouchUpInside];
//    [helperBtnView addSubview:helperControl];
//
//    UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake((80-26)/2, 10, 26, 26)];
//    imageview.image = [UIImage imageNamed:@"帮助"];
//    [helperBtnView addSubview:imageview];
//    UILabel *helperlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 46, 80, 20)];
//    helperlabel.text = @"帮助中心";
//    helperlabel.textColor = [UIColor blackColor];
//    helperlabel.textAlignment = NSTextAlignmentCenter;
//    helperlabel.font = [UIFont systemFontOfSize:12];
//    [helperBtnView addSubview:helperlabel];
//    [bottomView addSubview:helperBtnView];
//
//
//    UIView *adviceBtnView = [[UIView alloc]initWithFrame:CGRectMake(100, 10, 80 , 80)];
//    UIControl *adviceControl = [[UIControl alloc]initWithFrame:adviceBtnView.bounds];
//    [adviceControl addTarget:self action:@selector(adviceBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [adviceBtnView addSubview:adviceControl];
//    adviceBtnView.userInteractionEnabled = YES;
//    UIImageView *adviceimageview =[[UIImageView alloc]initWithFrame:CGRectMake((80-26)/2, 10, 26, 26)];
//    adviceimageview.image = [UIImage imageNamed:@"建议"];
//    [adviceBtnView addSubview:adviceimageview];
//    UILabel *advicelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 46, 80, 20)];
//    advicelabel.text = @"功能建议";
//    advicelabel.textColor = [UIColor blackColor];
//    advicelabel.textAlignment = NSTextAlignmentCenter;
//    advicelabel.font = [UIFont systemFontOfSize:12];
//    [adviceBtnView addSubview:advicelabel];
//    [bottomView addSubview:adviceBtnView];
//
//
//    UIView *aboutBtnView = [[UIView alloc]initWithFrame:CGRectMake(185, 10, 80 , 80)];
//    UIControl *aboutControl = [[UIControl alloc]initWithFrame:aboutBtnView.bounds];
//    [aboutControl addTarget:self action:@selector(aboutAction) forControlEvents:UIControlEventTouchUpInside];
//    [aboutBtnView addSubview:aboutControl];
//    aboutBtnView.userInteractionEnabled = YES;
//    UIImageView *aboutimageview =[[UIImageView alloc]initWithFrame:CGRectMake((80-26)/2, 10, 26, 26)];
//    aboutimageview.image = [UIImage imageNamed:@"aboutus"];
//    [aboutBtnView addSubview:aboutimageview];
//    UILabel *aboutlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 46, 80, 20)];
//    aboutlabel.text = @"关于我们";
//    aboutlabel.textColor = [UIColor blackColor];
//    aboutlabel.textAlignment = NSTextAlignmentCenter;
//    aboutlabel.font = [UIFont systemFontOfSize:12];
//    [aboutBtnView addSubview:aboutlabel];
//    [bottomView addSubview:aboutBtnView];
    
}
/*
 *  按钮事件
 */
-(void)btnClickAction:(UIButton*)btn{
    NSInteger tag = btn.tag - 1100;
    switch (tag) {
        case 0://帮助中心
        {
            //  [MobClick event:@"share_help"];
            HelpCenter1ViewController *vc = [[HelpCenter1ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case 1://意见反馈
        {
            //  [MobClick event:@"share_feedback"];
            FeatureSuggestionsViewController *vc = [[FeatureSuggestionsViewController alloc] init];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case 2://关于我们
        {
            //  [MobClick event:@"share_feedback"];
            AboutUs1ViewController * aboutUSView = [[AboutUs1ViewController alloc]init];
            [self.navigationController pushViewController:aboutUSView animated:YES];
        }
            break;
        default:
            break;
    }
}

/*
 *  share
 */
-(void)share{
    //  [MobClick event:@"output_share"];
    
    CGFloat bottom = 0;
    if (IOS11_OR_LATER) {
        bottom = self.view.safeAreaInsets.bottom;
    }

    PopShareView *shareView = [[PopShareView alloc]initWithShowFrame:CGRectMake(0, 0, kScreenWidth, 110+bottom) andAlpha:0.8];
    shareView.BtnClickAction = ^(NSInteger index,NSString *title,BOOL isInstall) {
        
        if ([title isEqualToString:@"QQ好友"]) {
            if (isInstall) {
//                [self shareTextPlatformType:UMSocialPlatformType_QQ];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您暂未安装QQ" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                
            }
            
        }
        if ([title isEqualToString:@"QQ空间"]) {
            if (isInstall) {
//                [self shareTextPlatformType:UMSocialPlatformType_Qzone];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您暂未安装QQ" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                
            }
            
        }
        if ([title isEqualToString:@"微信好友"]) {
            if (isInstall) {
                
//                [self shareTextPlatformType:UMSocialPlatformType_WechatSession];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您暂未安装微信" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];

            }
        }
        if ([title isEqualToString:@"朋友圈"]) {
            if (isInstall) {
                
//                [self shareTextPlatformType:UMSocialPlatformType_WechatTimeLine];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您暂未安装微信" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];

            }
        }
//        if ([title isEqualToString:@"收藏"]) {
//            [self shareTextPlatformType:UMSocialPlatformType_WechatFavorite];
//        }
        if ([title isEqualToString:@"新浪微博"]) {
//            if (isInstall) {
            
//                [self shareTextPlatformType:UMSocialPlatformType_Sina];
//            }
//            else{
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您暂未安装微博" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                [alert show];
//
//            }
        }
        if ([title isEqualToString:@"帮助"]) {
            
            HelpCenter1ViewController *vc = [[HelpCenter1ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:true];
            
        }
        if ([title isEqualToString:@"建议"]) {
            FeatureSuggestionsViewController *vc = [[FeatureSuggestionsViewController alloc] init];
            [self.navigationController pushViewController:vc animated:true];
        }

    };
    [shareView show];

}

/*
 *  关闭
 */
-(void)backTohome{
    //  [MobClick event:@"output_close"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
 *  分享的内容
 */

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
