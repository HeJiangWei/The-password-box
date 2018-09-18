//
//  DaShangJingJiRenVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "DaShangJingJiRenVC.h"
#import "DaShangPeopleIDModel.h"
@interface DaShangJingJiRenVC ()
{
    UILabel * hejiLab;//合计多少钱
}
@property(nonatomic,strong)UIView * view1;
@property(nonatomic,strong)UIView * view2;
@property(nonatomic,strong)UIButton * lastBtn;
@property(nonatomic,strong)NSArray *  titleArr;
@end

@implementation DaShangJingJiRenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"打赏经纪人";
    [self CreatView1];
    [self CreatView2];
}
#pragma mark --创建view1
-(void)CreatView1{
    _view1=[UIView new];
    _view1.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_view1]];
    _view1.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,10+64);
   //头像
    UIImageView * headImage =[UIImageView new];
    headImage.sd_cornerRadius=@(75/2);
    [headImage setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"my_photo"]];
    [_view1 sd_addSubviews:@[headImage]];
    headImage.sd_layout
    .leftSpaceToView(_view1,15)
    .topSpaceToView(_view1,10)
    .widthIs(75)
    .heightIs(75);
   //编号
    UILabel * bianHaoLabel =[UILabel new];
    bianHaoLabel.text=@"编号01";
    bianHaoLabel.font=[UIFont systemFontOfSize:16];
    bianHaoLabel.alpha=.8;
    [_view1 sd_addSubviews:@[bianHaoLabel]];
    bianHaoLabel.sd_layout
    .leftSpaceToView(headImage,20)
    .topSpaceToView(_view1,20)
    .heightIs(25);
    [bianHaoLabel setSingleLineAutoResizeWithMaxWidth:120];
    //电话
    UILabel * phoneLabel =[UILabel new];
    phoneLabel.text=@"电话 400-0123-456";
    phoneLabel.font=[UIFont systemFontOfSize:16];
    phoneLabel.alpha=.8;
    [_view1 sd_addSubviews:@[phoneLabel]];
    phoneLabel.sd_layout
    .leftEqualToView(bianHaoLabel)
    .topSpaceToView(bianHaoLabel,15)
    .heightIs(20);
    [phoneLabel setSingleLineAutoResizeWithMaxWidth:260];
    
    
    [Engine1 genJuJingJiRenID:_peopleID success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSDictionary * dicc =[dic objectForKey:@"Item3"];
            DaShangPeopleIDModel * md =[[DaShangPeopleIDModel alloc]initWithDaShangPhone:dicc];
            //头像
            [headImage setImageWithURL:[NSURL URLWithString:md.headImage] placeholderImage:[UIImage imageNamed:@"my_photo"]];
            //编号
            bianHaoLabel.text=md.nameLabel;//@"编号01";
            
            //电话
             phoneLabel.text=[NSString stringWithFormat:@"电话  %@",md.phoneLabel];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
    
    
    [_view1 setupAutoHeightWithBottomView:headImage bottomMargin:10];
    
    
}
-(void)CreatView2{
    _view2=[UIView new];
    _view2.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_view2]];
    _view2.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(_view1,10)
    .bottomSpaceToView(self.view,0);
    //雇佣费用
    UILabel * guLabel =[UILabel new];
    guLabel.text=@"雇佣费用";
    guLabel.font=[UIFont systemFontOfSize:18];
    guLabel.alpha=.6;
    [_view2 sd_addSubviews:@[guLabel]];
    guLabel.sd_layout
    .leftSpaceToView(_view2,15)
    .topSpaceToView(_view2,15)
    .heightIs(20);
    [guLabel setSingleLineAutoResizeWithMaxWidth:260];
    //雇佣按钮
    UIButton * guyongBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [guyongBtn setBackgroundImage:[UIImage imageNamed:@"guyongfeiyong"] forState:0];
   // [wangji addTarget:self action:@selector(wangji) forControlEvents:UIControlEventTouchUpInside];
    [_view2 sd_addSubviews:@[guyongBtn]];
    guyongBtn.sd_layout
    .leftEqualToView(guLabel)
    .topSpaceToView(guLabel,15)
    .widthIs(204/2)
    .heightIs(116/2);
    //打赏经纪人
    UILabel * dashangLab =[UILabel new];
    dashangLab.text=@"打赏经纪人";
    dashangLab.font=[UIFont systemFontOfSize:18];
    dashangLab.alpha=.6;
    [_view2 sd_addSubviews:@[dashangLab]];
    dashangLab.sd_layout
    .leftSpaceToView(_view2,15)
    .topSpaceToView(guyongBtn,20)
    .heightIs(20);
    [dashangLab setSingleLineAutoResizeWithMaxWidth:260];
    //6个按钮
    NSArray * imageArr =@[@"messege_line",@"messege_line",@"messege_line",@"messege_line",@"messege_line",@"messege_line"];
    NSArray * seleArr =@[@"messege_line_red",@"messege_line_red",@"messege_line_red",@"messege_line_red",@"messege_line_red",@"messege_line_red"];
    _titleArr =@[@"100",@"200",@"300",@"400",@"500",@"600"];
    UIButton * bbttnn;
        for (int i =0; i<6; i++) {
            UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:imageArr[i]] forState:0];
            btn.tag=i;
            bbttnn=btn;
            [btn setTitle:_titleArr[i] forState:0];
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage imageNamed:seleArr[i]] forState:UIControlStateSelected];
            [_view2 sd_addSubviews:@[btn]];
            btn.sd_layout
            .leftSpaceToView(_view2,15+(204/2+15)*(i%3))
            .topSpaceToView(dashangLab,10+(116/2+15)*(i/3))
            .widthIs(204/2)
            .heightIs(116/2);
            if (i==0) {
                btn.selected=YES;
                _lastBtn=btn;
            }
            
        }
    //合计
    hejiLab =[UILabel new];
    hejiLab.text=@"合计  1100元";
    hejiLab.textColor=[UIColor redColor];
    hejiLab.font=[UIFont systemFontOfSize:20];
    hejiLab.attributedText=[ToolClass attrStrFrom:hejiLab.text intFond:16 Color:[UIColor blackColor] numberStr:@"合计"];
    hejiLab.textAlignment=2;
    [_view2 sd_addSubviews:@[hejiLab]];
    hejiLab.sd_layout
    .rightSpaceToView(_view2,15)
    .topSpaceToView(bbttnn,20)
    .widthIs(260)
    .heightIs(20);
    //确认支付
    UIButton * sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"dashang_bt"] forState:0];
    [_view2 sd_addSubviews:@[sureBtn]];
    sureBtn.sd_layout
    .centerXEqualToView(_view2)
    .bottomSpaceToView(_view2,30)
    .widthIs(450/2)
    .heightIs(77/2);
   
    
}
-(void)btnClick:(UIButton*)btn{
    _lastBtn.selected=!_lastBtn.selected;
    btn.selected=!btn.selected;
    _lastBtn=btn;
    NSLog(@"输出%@",_titleArr[btn.tag]);
    int d = [_titleArr[btn.tag] intValue];
    hejiLab.text=[NSString stringWithFormat:@"合计   %d元",1000+d];
    hejiLab.attributedText=[ToolClass attrStrFrom:hejiLab.text intFond:16 Color:[UIColor blackColor] numberStr:@"合计"];
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
