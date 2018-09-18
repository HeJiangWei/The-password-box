//
//  WeiTuoPublicVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WeiTuoPublicVC.h"
#import "YuYinPublicVC.h"
@interface WeiTuoPublicVC ()
@property(nonatomic,strong)UIView * view1;
@end

@implementation WeiTuoPublicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self CreatView1];
    
}
-(void)CreatView1{
    _view1=[UIView new];
    _view1.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_view1]];
    _view1.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,50+64);
   
    
    UILabel * titleLabel =[UILabel new];
    titleLabel.text=@"请选择您要发布的类型";
    titleLabel.alpha=.8;
    titleLabel.font=[UIFont systemFontOfSize:16];
    titleLabel.textAlignment=1;
    titleLabel.textColor=[UIColor redColor];
    [_view1 sd_addSubviews:@[titleLabel]];
    titleLabel.sd_layout
    .centerXEqualToView(_view1)
    .heightIs(20)
    .topSpaceToView(_view1,30);
    [titleLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    NSArray * nameArr =@[@"weituo_bt1",@"weituo_bt2"];
    int d =(ScreenWidth-176*2)/3;
    for (int i=0; i<2; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:nameArr[i]] forState:0];
        [_view1 sd_addSubviews:@[btn]];
        btn.tag=i;
        [btn addTarget:self action:@selector(btnPublic:) forControlEvents:UIControlEventTouchUpInside];
        btn.sd_layout
        .topSpaceToView(titleLabel,10)
        .leftSpaceToView(_view1,d+(176+d)*i)
        .widthIs(176)
        .heightIs(236);
        [_view1 setupAutoHeightWithBottomView:btn bottomMargin:20];
    }
    
    
    
}
#pragma mark --发布按钮
-(void)btnPublic:(UIButton*)btn{
    if (btn.tag==0) {
        //语音发布
        YuYinPublicVC * vc =[YuYinPublicVC new];
        vc.hidesBottomBarWhenPushed=YES;
        vc.tagg=1;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //电话发布
    }
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
