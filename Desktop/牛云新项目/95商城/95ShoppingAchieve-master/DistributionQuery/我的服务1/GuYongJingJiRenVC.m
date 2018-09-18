//
//  GuYongJingJiRenVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "GuYongJingJiRenVC.h"
#import "SetViewController.h"
#import "ChoosePeopleVC.h"
@interface GuYongJingJiRenVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * view1;
}
@property (nonatomic,strong)UIButton * lastBtn;
@property (nonatomic,strong)UIView * lineView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIView * viewtwo;//400
@property(nonatomic,strong)UIView * view3;//置顶

@end

@implementation GuYongJingJiRenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的服务";
    [self shuJuData:@"1"];
    [self topView];//顶端3个按钮
    [self CeratTableView];
    [self Creat400FuWu];//400服务
    [self CreatZhiDingTop];//置顶服务
    [self phoneFuWu];
}
#pragma mark --解析短信服务
-(void)shuJuData:(NSString*)page{
    [Engine1 wodeFuWuMessageJiLuPage:page success:^(NSDictionary *dic) {
        
    } error:^(NSError *error) {
        
    }];
}
#pragma mark --解析电话服务
-(void)phoneFuWu{
    [Engine1 wodeDianHuaFuWuPage:@"1" Nsdata:@"2016-11-02" success:^(NSDictionary *dic) {
        
    } error:^(NSError *error) {
        
    }];
    
}
-(void)topView{
    view1=[UIView new];
    view1.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[view1]];
    view1.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64+5)
    .heightIs(160);
    //红线
    _lineView=[UIView new];
    _lineView.alpha=.7;
    _lineView.backgroundColor=[UIColor redColor];
    [view1 sd_addSubviews:@[_lineView]];
    //3个按钮
    NSArray * imageArr=@[@"ms_messege",@"ms_400",@"ms_zd"];
    NSArray * titleArr=@[@"短信服务",@"400服务",@"置顶服务"];
    int d =(ScreenWidth-ScreenWidth/4*3)/4 ;
    for (int i =0; i<titleArr.count; i++) {
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:0];
         [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.tag=i;
        [button addTarget:self action:@selector(buttonClinck:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.alpha=.6;
        button.titleLabel.font=[UIFont systemFontOfSize:14];
        button.titleLabel.textAlignment=1;
        [view1 sd_addSubviews:@[button]];
        button.sd_layout
        .leftSpaceToView(view1,d+(d+ScreenWidth/4)*i)
        .topSpaceToView(view1,5)
        .widthIs(ScreenWidth/4)
        .heightIs(ScreenWidth/8);
        
        
        // 设置button的图片的约束
        button.imageView.sd_layout
        .widthIs(42/2)
        .topSpaceToView(button, 0)
        .centerXEqualToView(button)
        .heightIs(42/2);
        
        // 设置button的label的约束
        button.titleLabel.sd_layout
        .topSpaceToView(button.imageView, 5)
        .leftSpaceToView(button,2)
        .rightSpaceToView(button,2)
        .heightIs(20);
        
        if (i==0) {
            button.selected=YES;
            _lastBtn=button;
            _lineView.sd_layout
            .leftEqualToView(button)
            .rightEqualToView(button)
            .topSpaceToView(button,5)
            .heightIs(2);
        }
    }
    [view1 setupAutoHeightWithBottomView:_lineView bottomMargin:5];
    
    
}

#pragma mark --顶头3个按钮点击
-(void)buttonClinck:(UIButton*)button{
    _lastBtn.selected=!_lastBtn.selected;
    button.selected=!button.selected;
    _lastBtn=button;
    [view1 sd_addSubviews:@[_lineView]];
    [UIView animateWithDuration:.5 animations:^{
        _lineView.sd_layout
        .leftEqualToView(_lastBtn)
        .rightEqualToView(_lastBtn)
        .topSpaceToView(_lastBtn,5)
        .heightIs(2);
    }];
    
    if (button.tag==0) {
        //短信服务
        self.tableView.hidden=NO;
        self.viewtwo.hidden=YES;
        self.view3.hidden=YES;
    }else if (button.tag==1){
        //400服务
        self.tableView.hidden=YES;
        self.viewtwo.hidden=NO;
        self.view3.hidden=YES;
    }else{
        //置顶服务
        self.tableView.hidden=YES;
        self.viewtwo.hidden=YES;
        self.view3.hidden=NO;
    }
    
}
#pragma mark --区头(短信服务)
-(UIView*)headView
{
    UIView * headView =[UIView new];
    headView.backgroundColor=[UIColor whiteColor];
    headView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(120)
    .topSpaceToView(view1,5);
    //红圈
    UIImageView * imageview =[UIImageView new];
    imageview.image=[UIImage imageNamed:@"ms_quan(1)"];
    [headView sd_addSubviews:@[imageview]];
    imageview.sd_layout
    .leftSpaceToView(headView,15)
    .topSpaceToView(headView,20)
    .widthIs(174/2)
    .heightIs(174/2);
    //条数
    UILabel * tiaoshuLab =[UILabel new];
    tiaoshuLab.text=@"200";
    tiaoshuLab.textAlignment=1;
    tiaoshuLab.textColor=[UIColor redColor];
    tiaoshuLab.font=[UIFont systemFontOfSize:18];
    [imageview sd_addSubviews:@[tiaoshuLab]];
    tiaoshuLab.sd_layout
    .centerXEqualToView(imageview)
    .topSpaceToView(imageview,15)
    .widthIs(70)
    .heightIs(20);
    //还剩
    UILabel * shengYu =[UILabel new];
    shengYu.text=@"还剩(条)";
    shengYu.textColor=[UIColor blackColor];
    shengYu.alpha=.6;
    shengYu.textAlignment=1;
    shengYu.font=[UIFont systemFontOfSize:14];
    [imageview sd_addSubviews:@[shengYu]];
    shengYu.sd_layout
    .centerXEqualToView(imageview)
    .topSpaceToView(tiaoshuLab,10)
    .widthIs(70)
    .heightIs(20);
   
    //短信服务
    UILabel * fuwuLabel =[UILabel new];
    fuwuLabel.text=@"短信服务";
    fuwuLabel.textColor=[UIColor blackColor];
    fuwuLabel.alpha=1;
    fuwuLabel.font=[UIFont systemFontOfSize:18];
    [headView sd_addSubviews:@[fuwuLabel]];
    fuwuLabel.sd_layout
    .leftSpaceToView(imageview,25)
    .topSpaceToView(headView,35)
    .heightIs(20);
    [fuwuLabel setSingleLineAutoResizeWithMaxWidth:180];
//    //共500已发送
    UILabel * totleLable =[UILabel new];
    totleLable.text=@"共500条,已发送300条";
    totleLable.textColor=[UIColor blackColor];
    totleLable.alpha=.6;
    [headView sd_addSubviews:@[totleLable]];
    totleLable.sd_layout
    .leftEqualToView(fuwuLabel)
    .topSpaceToView(fuwuLabel,10)
    .rightSpaceToView(headView,15)
    .heightIs(20);
    
    
    
    return headView;
}
-(void)CeratTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableFooterView=[UIView new];
    _tableView.tableHeaderView=[self headView];
    [self.view sd_addSubviews:@[_tableView]];
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(view1,2)
    .bottomSpaceToView(self.view,0);
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text=@"山东馈线回收威海市荣成有限公司活动中心获取";
    cell.textLabel.alpha=.6;
    cell.textLabel.font=[UIFont systemFontOfSize:16];
    cell.detailTextLabel.text=@"2016-12-12";
    cell.detailTextLabel.alpha=.5;
    cell.detailTextLabel.font=[UIFont systemFontOfSize:13];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[UIView new];
    view.backgroundColor=[UIColor whiteColor];
    UIImageView * imageview =[UIImageView new];
    imageview.image=[UIImage imageNamed:@"ms_line"];
    [view sd_addSubviews:@[imageview]];
    imageview.sd_layout
    .leftSpaceToView(view,15)
    .centerYEqualToView(view)
    .widthIs(4)
    .heightIs(30/2);
    
    UILabel * nameLabel =[UILabel new];
    nameLabel.font=[UIFont systemFontOfSize:15];
    nameLabel.alpha=.7;
    nameLabel.text=@"发送记录";
    [view sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(imageview,15)
    .centerYEqualToView(imageview)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    
    return view;
}
#pragma mark --400服务
-(void)Creat400FuWu{
    _viewtwo=[UIView new];
    _viewtwo.backgroundColor=[UIColor whiteColor];
    _viewtwo.hidden=YES;
    [self.view sd_addSubviews:@[_viewtwo]];
    _viewtwo.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(view1,3)
    .heightIs(150);
    
    //红圈
    UIImageView * imageview =[UIImageView new];
    imageview.image=[UIImage imageNamed:@"ms_quan(1)"];
    [_viewtwo sd_addSubviews:@[imageview]];
    imageview.sd_layout
    .centerXEqualToView(_viewtwo)
    .topSpaceToView(_viewtwo,25)
    .widthIs(174/2)
    .heightIs(174/2);
    //条数
    UILabel * tiaoshuLab =[UILabel new];
    tiaoshuLab.text=@"1000";
    tiaoshuLab.textAlignment=1;
    tiaoshuLab.textColor=[UIColor redColor];
    tiaoshuLab.font=[UIFont systemFontOfSize:18];
    [imageview sd_addSubviews:@[tiaoshuLab]];
    tiaoshuLab.sd_layout
    .centerXEqualToView(imageview)
    .topSpaceToView(imageview,15)
    .widthIs(70)
    .heightIs(20);
    //还剩
    UILabel * shengYu =[UILabel new];
    shengYu.text=@"还剩(分钟)";
    shengYu.textColor=[UIColor blackColor];
    shengYu.alpha=.6;
    shengYu.textAlignment=1;
    shengYu.font=[UIFont systemFontOfSize:14];
    [imageview sd_addSubviews:@[shengYu]];
    shengYu.sd_layout
    .centerXEqualToView(imageview)
    .topSpaceToView(tiaoshuLab,10)
    .widthIs(70)
    .heightIs(20);
    //电话号码
    UILabel * phoneLable =[UILabel new];
    phoneLable.text=@"400-1458-569";
    phoneLable.textColor=[UIColor blackColor];
    phoneLable.alpha=.8;
    phoneLable.textAlignment=1;
    phoneLable.font=[UIFont systemFontOfSize:17];
    [_viewtwo sd_addSubviews:@[phoneLable]];
    phoneLable.sd_layout
    .centerXEqualToView(imageview)
    .topSpaceToView(imageview,20)
    .heightIs(20);
    [phoneLable setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    //共剩余多少分钟
    UILabel * shengYuLabel =[UILabel new];
    shengYuLabel.text=@"共5000分钟,已使用4000分";
    shengYuLabel.textColor=[UIColor blackColor];
    shengYuLabel.alpha=.6;
    shengYuLabel.textAlignment=1;
    shengYuLabel.font=[UIFont systemFontOfSize:14];
    [_viewtwo sd_addSubviews:@[shengYuLabel]];
    shengYuLabel.sd_layout
    .centerXEqualToView(phoneLable)
    .topSpaceToView(phoneLable,10)
    .heightIs(20);
    [shengYuLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];

    [_viewtwo setupAutoHeightWithBottomView:shengYuLabel bottomMargin:10];
    
}
#pragma mark --置顶服务
-(void)CreatZhiDingTop{
    _view3=[UIView new];
    _view3.hidden=YES;
    _view3.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_view3]];
    _view3.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(view1,3)
    .heightIs(150);
    
    UIImageView * imageview =[[UIImageView alloc]init];
    imageview.image=[UIImage imageNamed:@"ms_zw"];
    [_view3 sd_addSubviews:@[imageview]];
    imageview.sd_layout
    .topSpaceToView(_view3,20)
    .centerXEqualToView(_view3)
    .widthIs(174/2)
    .heightIs(174/2);
    
    
    UILabel * label =[UILabel new];
    label.text=@"此功能尚未开通,敬请期待~";
    label.textColor=[UIColor blackColor];
    label.alpha=.6;
    label.textAlignment=1;
    label.font=[UIFont systemFontOfSize:16];
    [_view3 sd_addSubviews:@[label]];
    label.sd_layout
    .centerXEqualToView(imageview)
    .topSpaceToView(imageview,10)
    .heightIs(20);
    [label setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    [_view3 setupAutoHeightWithBottomView:label bottomMargin:20];
    
    
    
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
