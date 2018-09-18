//
//  JinDianChaKanVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "JinDianChaKanVC.h"
#import "JinDianChaKanCell.h"
#import "AllShangPinVC.h"
#import "JinDianModel.h"
#import "XiangQingVC.h"
@interface JinDianChaKanVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray1;
@property(nonatomic,strong)NSMutableArray * dataArray2;
@property(nonatomic,strong)NSMutableArray * dataArray3;
@property(nonatomic,strong)NSMutableArray * dataArray4;
@end

@implementation JinDianChaKanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"进店查看";
    self.automaticallyAdjustsScrollViewInsets=NO;
     _dataArray1=[NSMutableArray new];
     _dataArray2=[NSMutableArray new];
     _dataArray3=[NSMutableArray new];
     _dataArray4=[NSMutableArray new];
    [self CreatRightBtn];
    [self jieXiData];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=COLOR;
    _tableView.tableHeaderView=[self CreatTableViewHead];
    [self.view addSubview:_tableView];
}
-(void)jieXiData{
    NSLog(@"输出来%@",_messageID);
    [Engine1 huoQuDianPuFirstMessageID:_messageID success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
              NSArray * itme4 =[dic objectForKey:@"Item4"];//最新
              NSArray * itme5 =[dic objectForKey:@"Item5"];//经典
             NSArray * itme6 =[dic objectForKey:@"Item6"];//优质
            if (itme4.count!=0) {
                for (NSDictionary * dic4 in itme4) {
                    JinDianModel * md =[[JinDianModel alloc]initWithDiQuDic:dic4];
                    [_dataArray1 addObject:md];
                    NSLog(@"输出一下数量%lu",_dataArray1.count);
                }
                [_tableView reloadData];
            }
            if (itme5.count!=0) {
                for (NSDictionary * dic4 in itme5) {
                    JinDianModel * md =[[JinDianModel alloc]initWithDiQuDic:dic4];
                    [_dataArray2 addObject:md];
                }
                 [_tableView reloadData];
            }
            if (itme6.count!=0) {
                for (NSDictionary * dic4 in itme6) {
                    JinDianModel * md =[[JinDianModel alloc]initWithDiQuDic:dic4];
                    [_dataArray3 addObject:md];
                }
                 [_tableView reloadData];
            }
//            if (_dataArray1.count!=0) {
//                [_dataArray4 addObject:_dataArray1];
//            }
//            if (_dataArray2.count!=0) {
//                [_dataArray4 addObject:_dataArray2];
//            }
//            if (_dataArray3.count!=0) {
//                [_dataArray4 addObject:_dataArray3];
//            }
            [_tableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark --创建右按钮
-(void)CreatRightBtn{
    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    //搜索按钮
    rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //[rightBtn setTitle:@"搜索" forState:0];
    [rightBtn setImage:[UIImage imageNamed:@"dianpu_shoucang"] forState:0];
    [rightBtn setImage:[UIImage imageNamed:@"xiangqing_shou_click"] forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(shouCangBtn:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    rightBtn.frame=CGRectMake(0, 0, 50, 50);
    UIBarButtonItem * rightBtnn =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems=@[rightBtnn];
}


#pragma mark --收藏
-(void)shouCangBtn:(UIButton*)btn{
    btn.selected=!btn.selected;
}

-(UIView*)CreatTableViewHead{
    UIView * headView =[UIView new];
    headView.backgroundColor=COLOR;
//    headView.sd_layout
//    .leftSpaceToView(self.view,0)
//    .rightSpaceToView(self.view,0)
//    .topSpaceToView(self.view,0);
  headView.frame=CGRectMake(0, 0, ScreenWidth, 405);
    //背景图
    UIImageView * bgImage =[[UIImageView alloc]init];
    bgImage.image=[UIImage imageNamed:@"xiangqing_banner"];
    [headView sd_addSubviews:@[bgImage]];
    bgImage.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(headView,0)
    .heightIs(376*ScreenWidth/750);
    UIView * whiteView =[UIView new];
    whiteView.backgroundColor=[UIColor whiteColor];
    [headView sd_addSubviews:@[whiteView]];
    whiteView.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(bgImage,0);
    
    
    //头像
    UIImageView * headImage =[[UIImageView alloc]init];
    headImage.sd_cornerRadius=@(75/2);
    [whiteView sd_addSubviews:@[headImage]];
    headImage.sd_layout
    .centerXEqualToView(whiteView)
    .topSpaceToView(whiteView,-75/2)
    .heightIs(75)
    .widthIs(75);
    //titleName(公司的名字)
    UILabel * comLabel =[UILabel new];
    comLabel.font=[UIFont systemFontOfSize:16];
    comLabel.alpha=.8;
    [whiteView sd_addSubviews:@[comLabel]];
    comLabel.sd_layout
    .topSpaceToView(headImage,10)
    .heightIs(20)
    .centerXEqualToView(headImage);
    [comLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    //担
    UIImageView * imageDan =[[UIImageView alloc]init];
    imageDan.image=[UIImage imageNamed:@"xianhuo_dan"];
    [whiteView sd_addSubviews:@[imageDan]];
    imageDan.sd_layout
    .leftSpaceToView(comLabel,5)
    .centerYEqualToView(comLabel)
    .heightIs(20)
    .widthIs(20);
    //认证图标
    UIImageView * renzheng =[[UIImageView alloc]init];
    renzheng.image=[UIImage imageNamed:@"xianhuo_v"];
    [whiteView sd_addSubviews:@[renzheng]];
    renzheng.sd_layout
    .leftSpaceToView(imageDan,5)
    .centerYEqualToView(comLabel)
    .heightIs(34/2)
    .widthIs(34/2);
    
    
    
    //地区
    UILabel * address =[UILabel new];
    address.font=[UIFont systemFontOfSize:14];
    address.alpha=.6;
    [whiteView sd_addSubviews:@[address]];
    address.sd_layout
    .topSpaceToView(comLabel,10)
    .heightIs(20)
    .leftEqualToView(comLabel);
    [address setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    //收藏次数
    UILabel * shouCang =[UILabel new];
    shouCang.font=[UIFont systemFontOfSize:14];
    shouCang.alpha=.6;
    [whiteView sd_addSubviews:@[shouCang]];
    shouCang.sd_layout
    .topEqualToView(address)
    .heightIs(20)
    .leftSpaceToView(address,20);
    [shouCang setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    //拨打电话
    UIButton * phoneBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    
    [phoneBtn setBackgroundImage:[UIImage imageNamed:@"dianpu_phone-1"] forState:0];
    [phoneBtn setTitleColor:[UIColor blackColor] forState:0];
    phoneBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [whiteView sd_addSubviews:@[phoneBtn]];
    phoneBtn.sd_layout
    .centerXEqualToView(headView)
    .topSpaceToView(address,10)
    .heightIs(36/2)
    .widthIs(268/2);
    [ whiteView setupAutoHeightWithBottomView:phoneBtn bottomMargin:10];
//店铺id传递的是
    [Engine1 huoQuDianPuFirstMessageID:_messageID success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            //NSArray * item3 =[dic objectForKey:@"Item3"];
            NSDictionary * dicc =[dic objectForKey:@"Item3"];
            [bgImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[dicc objectForKey:@"M_PlaceImg"]]] placeholderImage:[UIImage imageNamed:@"xiangqing_banner"]];
            //头像
            [headImage setImageWithURL:[NSURL URLWithString:[ToolClass isString:[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,[dicc objectForKey:@"M_HeadImg"]]]] placeholderImage:[UIImage imageNamed:@"my_photo"]];
            //公司名字
             comLabel.text=[ToolClass isString:[dicc objectForKey:@"M_CompanyName"]];
            //地区
            address.text=[ToolClass isString:[dicc objectForKey:@"M_Address"]];
            //收藏次数//字段不确定
            shouCang.text=[ToolClass isString:[NSString stringWithFormat:@"收藏次数  %@",[dicc objectForKey:@"M_Category"]]];
            //400电话
            [phoneBtn setTitle:[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"E_Number"]]] forState:0];
            //M_Id 是店铺ID
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
    
    
    //几个按钮图标题
    UIView * view2 =[UIView new];
    view2.backgroundColor=[UIColor whiteColor];
    [headView sd_addSubviews:@[view2]];
    view2.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(whiteView,10);
    //循环btn
    int d =(ScreenWidth-50*5)/6;
    NSArray * btnArr =@[@"dianpu_index_before",@"dianpu_all",@"dianpu_new",@"dianpu_jiu",@"dianpu_you"];
    for (int i =0; i<5; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:btnArr[i]] forState:UIControlStateNormal];
        [view2 sd_addSubviews:@[btn]];
        btn.tag=i+10;
        [btn addTarget:self action:@selector(dianjiBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.sd_layout
        .leftSpaceToView(view2,d+(50+d)*i)
        .topSpaceToView(view2,5)
        .widthIs(100/2)
        .heightIs(90/2);
       [view2 setupAutoHeightWithBottomView:btn bottomMargin:10];
    }

    UIView * view3 =[UIView new];
    view3.backgroundColor=COLOR;//[UIColor yellowColor];
    [headView sd_addSubviews:@[view3]];
    view3.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(view2,0)
    .heightIs(10);
    
   // [headView setupAutoHeightWithBottomView:view3 bottomMargin:0];
    return headView;
}
#pragma mark --表头5个按钮
-(void)dianjiBtn:(UIButton*)btn{
    if (btn.tag==10) {
        
    }else{
        AllShangPinVC * vc =[AllShangPinVC new];
        vc.tagg=btn.tag;
        vc.messageID=_messageID;//走的是店铺ID
        vc.cidd=btn.tag-11;//0全部 1最新 2经典 3优质
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return _dataArray1.count;
    }else if (section==1){
        return _dataArray2.count;
    }else{
        return _dataArray3.count;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    JinDianChaKanCell * cell =[JinDianChaKanCell cellWithTableView:tableView CellID:CellIdentifier];
    cell.chaKanBtn.tag=indexPath.row;
    //[cell.chaKanBtn addTarget:self action:@selector(chaKan:) forControlEvents:UIControlEventTouchUpInside];
    cell.chaKanBtn.hidden=YES;
    if (indexPath.section==0) {
         cell.model=_dataArray1[indexPath.row];
    }else if (indexPath.section==1){
         cell.model=_dataArray2[indexPath.row];
    }else{
         cell.model=_dataArray3[indexPath.row];
    }
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[UIView new];
    view.backgroundColor=[UIColor whiteColor];
    UILabel * label =[UILabel new];
    label.font=[UIFont systemFontOfSize:16];
    label.alpha=.8;
    [view sd_addSubviews:@[label]];
    label.sd_layout
    .leftSpaceToView(view,15)
    .centerYEqualToView(view)
    .heightIs(20);
    [label setSingleLineAutoResizeWithMaxWidth:200];
    //更多
    UIButton * moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.tag=section;
    [moreBtn setImage:[UIImage imageNamed:@"dianpu_arrow-1"] forState:0];
    [moreBtn addTarget:self action:@selector(gengDuoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view sd_addSubviews:@[moreBtn]];
    moreBtn.sd_layout
    .rightSpaceToView(view,15)
    .centerYEqualToView(view)
    .widthIs(81/2)
    .heightIs(29/2);
    
    if (section==0) {
        label.text=@"新品上架";
    }else if (section==1){
        label.text=@"经典旧货";
    }else{
        label.text=@"优质好货";
    }
    return view;
}
#pragma mark --更多
-(void)gengDuoBtn:(UIButton*)btn{
    NSLog(@">>>>%lu",btn.tag);
    AllShangPinVC * vc =[AllShangPinVC new];
    vc.tagg=btn.tag+12;
    vc.messageID=_messageID;
    vc.cidd=btn.tag+1;// 1最新 2经典 3优质
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     AllShangPinVC * vc =[AllShangPinVC new];
    vc.tagg=indexPath.section+12;
    vc.messageID=_messageID;
    vc.cidd=indexPath.section+1;// 1最新 2经典 3优质
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        return [_tableView cellHeightForIndexPath:indexPath model:_dataArray1[indexPath.row]keyPath:@"model" cellClass:[JinDianChaKanCell class] contentViewWidth:[ToolClass  cellContentViewWith]];;
  
    }else if (indexPath.section==1){
        return [_tableView cellHeightForIndexPath:indexPath model:_dataArray2[indexPath.row]keyPath:@"model" cellClass:[JinDianChaKanCell class] contentViewWidth:[ToolClass  cellContentViewWith]];;

    }else{
        return [_tableView cellHeightForIndexPath:indexPath model:_dataArray3[indexPath.row]keyPath:@"model" cellClass:[JinDianChaKanCell class] contentViewWidth:[ToolClass  cellContentViewWith]];;

    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
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
