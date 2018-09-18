//
//  MyVC.m
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MyVC.h"
#import "SetViewController.h"
#import "LoginVC.h"
#import "GuanLiViewController.h"
#import "ShouCangVC.h"
#import "SuggestionVC.h"
#import "GuYongJingJiRenVC.h"
#import "FuWuChongZhiZhenVC.h"
#import "GuanYu95VC.h"
#import "XiaoXiTongZhiVC.h"
@interface MyVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * imageArray;
@property(nonatomic,copy)NSString * headUrl;
@end

@implementation MyVC
-(void)viewWillAppear:(BOOL)animated
{
     [self CreatTableView];//创建表
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    // Do any additional setup after loading the view.
    self.title=@"我的";
    self.backHomeBtn.hidden=YES;
   // [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:TITLE_FOUNT]}];
    //self.na
    [self CreatDataArr];//数据源
   // [self CreatTableView];//创建表
}

#pragma mark --创建数据源
-(void)CreatDataArr{
    NSArray * arr1 =@[@"管理",@"收藏"];
    NSArray * arr2=@[@"我的服务",@"服务充值"];
    NSArray * arr3 =@[@"消息通知",@"意见反馈"];
    NSArray * arr4 =@[@"关于95"];
    _dataArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2,arr3,arr4, nil];
    
    NSArray * image1 =@[@"my_guanli",@"my_shoucang"];
    NSArray * image2 =@[@"my_se",@"my_service"];
     NSArray * image3 =@[@"my_message",@"my_fankui"];
    NSArray * image4 =@[@"my_our"];
    _imageArray=[[NSMutableArray alloc]initWithObjects:image1,image2,image3,image4, nil];
}
#pragma mark --获取头像
-(void)getImageHead{
    [Engine1 huoQuImageWithType:@"0" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * imageHead =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc  in imageHead) {
                _headUrl =[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[dicc objectForKey:@"Img_Url"]];
            }
             _tableView.tableHeaderView=[self tableViewHead];
           // [_tableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}

#pragma mark --表头
-(UIView*)tableViewHead{
    UIImageView * headView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"my_bg"]];
    headView.userInteractionEnabled=YES;
    headView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64)
    .heightIs(ScreenWidth*26/75);
    //头像
    UIImageView * headImageView =[UIImageView new];
    headImageView.sd_cornerRadius=@(40);
    [headImageView setImageWithURL:[NSURL URLWithString:_headUrl] placeholderImage:[UIImage imageNamed:@"my_photo"]];
    [headView sd_addSubviews:@[headImageView]];
    headImageView.sd_layout
    .leftSpaceToView(headView,15)
    .centerYEqualToView(headView)
    .widthIs(80)
    .heightIs(80);
    //小角标但
    UIImageView * imagedan =[UIImageView new];
    imagedan.image=[UIImage imageNamed:@"my_danbao"];
    [headView sd_addSubviews:@[imagedan]];
    imagedan.sd_layout
    .leftSpaceToView(headImageView,-20)
    .bottomEqualToView(headImageView)
    .widthIs(33/2)
    .heightIs(33/2);
  
   
    //登录按钮
    UIButton * loginBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setImage:[UIImage imageNamed:@"weidenglu"] forState:0];
    [loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headView sd_addSubviews:@[loginBtn]];
    loginBtn.sd_layout
    .leftSpaceToView(headImageView,15)
    .centerYEqualToView(headImageView)
    .widthIs(164/2)
    .heightIs(67/2);
    
    
    //标题
    NSDictionary * dicc =[ToolClass duquPlistWenJianPlistName:@"Login"];
    UILabel * titleLabel=[UILabel new];
    titleLabel.text=[dicc objectForKey:@"M_UserName"];//@"江苏物业公司经理";
    titleLabel.alpha=.8;
    [headView sd_addSubviews:@[titleLabel]];
    titleLabel.sd_layout
    .leftSpaceToView(headImageView,15)
    .topSpaceToView(headView,ScreenWidth*26/75/2-20)
    .heightIs(20);
    [titleLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    //副标题
    UILabel * deTitleLable=[UILabel new];
    deTitleLable.text=@"您好！欢迎来到95商城!";
    deTitleLable.alpha=.7;
    deTitleLable.font=[UIFont systemFontOfSize:15];
    [headView sd_addSubviews:@[deTitleLable]];
    deTitleLable.sd_layout
    .leftEqualToView(titleLabel)
    .topSpaceToView(titleLabel,10)
    .heightIs(20);
    [deTitleLable setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    if ([ToolClass isLogin]) {
        deTitleLable.hidden=NO;
        titleLabel.hidden=NO;
        loginBtn.hidden=YES;
    }else{
        deTitleLable.hidden=YES;
        titleLabel.hidden=YES;
        loginBtn.hidden=NO;
    }
    //右上角设置
    UIButton * sheZhiBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [sheZhiBtn setImage:[UIImage imageNamed:@"my_set"] forState:0];
    [sheZhiBtn addTarget:self action:@selector(shezhiBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headView sd_addSubviews:@[sheZhiBtn]];
    sheZhiBtn.sd_layout
    .rightSpaceToView(headView,20)
    .topSpaceToView(headView,20)
    .widthIs(30)
    .heightIs(30);
    return headView;
}
#pragma mark --设置按钮
-(void)shezhiBtn:(UIButton*)btn{
    if ([ToolClass isLogin]==NO) {
        LoginVC * vc =[LoginVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }

    SetViewController * vc =[SetViewController new];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --登录按钮
-(void)loginBtn:(UIButton*)btn{
    LoginVC * vc =[LoginVC new];
     vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark --创建表
-(void)CreatTableView
{
  
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    }
    _tableView.tableFooterView=[UIView new];
    _tableView.tableHeaderView=[self tableViewHead];
    _tableView.backgroundColor=COLOR;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    [self.view addSubview:_tableView];
    [self getImageHead];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr =_dataArray[section];
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UIImageView * imageview =[UIImageView new];
        imageview.tag=1;
        UILabel * label =[UILabel new];
        label.tag=2;
        [cell sd_addSubviews:@[imageview,label]];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIImageView * imageview =(UIImageView*)[cell viewWithTag:1];
    UILabel * label =(UILabel *)[cell viewWithTag:2];
    label.font=[UIFont systemFontOfSize:16];
    label.alpha=.7;
    imageview.sd_layout
    .leftSpaceToView(cell,20)
    .centerYEqualToView(cell)
    .widthIs(18)
    .heightIs(18);
    
    label.sd_layout
    .leftSpaceToView(imageview,10)
    .centerYEqualToView(imageview)
    .heightIs(20);
    [label setSingleLineAutoResizeWithMaxWidth:120];
    
    imageview.image=[UIImage imageNamed:_imageArray[indexPath.section][indexPath.row]];
    label.text=_dataArray[indexPath.section][indexPath.row];

  
    return cell;
}
#pragma mark --表的点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([ToolClass isLogin]==NO) {
        LoginVC * vc =[LoginVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //管理
            GuanLiViewController * vc =[GuanLiViewController new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //收藏
            ShouCangVC* vc =[ShouCangVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if(indexPath.section==1){
        if (indexPath.row==0) {
            //我的服务
            GuYongJingJiRenVC * vc =[GuYongJingJiRenVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //服务充值
            FuWuChongZhiZhenVC * vc =[FuWuChongZhiZhenVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
 
        }
        
    }else if(indexPath.section==2){
        if (indexPath.row==0) {
            //消息通知
            XiaoXiTongZhiVC * vc =[XiaoXiTongZhiVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //意见反馈
            SuggestionVC * vc =[SuggestionVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        //关于95
        GuanYu95VC * vc =[GuanYu95VC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 50;
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
