//
//  XiangQingVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "XiangQingVC.h"
#import "YouZhiXianHuoCell.h"
#import "XiangQingModel.h"
#import "JinDianChaKanVC.h"
@interface XiangQingVC ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
     SDCycleScrollView *cycleScrollView2;
//    UILabel * titleLable1;
}
//@property(nonatomic,strong)UIScrollView * bgScrollView;//背景的滚动试图
@property(nonatomic,strong)UIView * view1;
@property(nonatomic,strong)UIView * view2;
@property(nonatomic,strong)UIView * view3;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIButton * lastBtn;//用来记录上一条下一条的

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * tableArray;
@property(nonatomic,copy)NSString * xiaID;
@property(nonatomic,copy)NSString * shangID;

@end
@implementation XiangQingVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"详情页";
//    _dataArray=[NSMutableArray new];
    _tableArray=[NSMutableArray new];
     [self CeratTableView];
    //[self jieXiXiangQingYeDataChanPinID:_messageID];
   
   
}



////#pragma mark --解析详情页的数据
//-(void)jieXiXiangQingYeDataChanPinID:(NSString*)chanPin{
//    //@"7458" _messageID
//    if (_tagg==1 || _tagg==3) {
//        //现货详情
//        [_dataArray removeAllObjects];
//        [_tableArray removeAllObjects];
//        [Engine ChanPinDianPuXiangQingDianPuID:_dianPuID ChanPinID:chanPin success:^(NSDictionary *dic) {
//            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
//            if ([item1 isEqualToString:@"1"]) {
//                //item4产品详情  item5猜你喜欢 item3公司资料 item6上一条 item7下一条
//                NSDictionary * dic4 =[dic objectForKey:@"Item4"];
//                XiangQingModel * md =[[XiangQingModel alloc]initWithXiangXiDic:dic4];
//                [_dataArray addObject:md];
//
//                NSArray * item5Arr =[dic objectForKey:@"Item5"];
//                for (NSDictionary * dic5 in item5Arr) {
//                    XiangQingModel * mdd =[[XiangQingModel alloc]initWithCaiNiLikeDic:dic5];
//                    [_tableArray addObject:mdd];
//                }
//                _shangID=[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item6"]];
//                _xiaID=[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item7"]];
//                 //  _tableView.tableHeaderView=[self CreatHeadView];
//                [_tableView reloadData];
//                
//            }else{
//                [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
//            }
//        } error:^(NSError *error) {
//
//        }];
//
//
//
//    }else if (_tagg==2){
//        //最新采购详情
//        [Engine zuiXinCaiGouXiangQingMessageID:_messageID success:^(NSDictionary *dic) {
//            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
//            if ([item1 isEqualToString:@"1"]) {
//                NSDictionary * itemDicr=[dic objectForKey:@"Item2"];
//                XiangQingModel * md =[[XiangQingModel alloc]initWithZuiXinCiGouXiangXiDic:itemDicr];
//                [_dataArray addObject:md];
//               // _tableView.tableHeaderView=[self CreatHeadView];
//                [_tableView reloadData];
//            }else{
//                [LCProgressHUD showMessage:[dic objectForKey:@"Item3"]];
//            }
//        } error:^(NSError *error) {
//
//        }];
//    }
//
//}





#pragma mark --创建表
-(void)CeratTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableHeaderView=[self CreatHeadView:_messageID];
    _tableView.tableFooterView=[UIView new];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    YouZhiXianHuoCell * cell =[YouZhiXianHuoCell cellWithTableView:tableView CellID:CellIdentifier];
    cell.chaKanBtn.tag=indexPath.row;
    cell.chaKanBtn.hidden=YES;
    cell.md=_tableArray[indexPath.row];
    return cell;
}
////区头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView =[UIView new];
    headView.backgroundColor=[UIColor whiteColor];
   
    //数线
    UIImageView * lineView =[UIImageView new];
    lineView.image=[UIImage imageNamed:@"xianqing_line"];
    [headView sd_addSubviews:@[lineView]];
    lineView.sd_layout
    .leftSpaceToView(headView,15)
    .topSpaceToView(headView,15)
    .widthIs(4)
    .heightIs(16);
    //titlename
    UILabel * titleName =[UILabel new];
    titleName.text=@"猜你喜欢❤️";
    titleName.alpha=.7;
    titleName.font=[UIFont systemFontOfSize:16];
    [headView sd_addSubviews:@[titleName]];
    titleName.sd_layout
    .leftSpaceToView(lineView,5)
    .centerYEqualToView(lineView)
    .heightIs(15);
    [titleName setSingleLineAutoResizeWithMaxWidth:150];


    return headView;
}
//区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_tableView cellHeightForIndexPath:indexPath model:_tableArray[indexPath.row]keyPath:@"md" cellClass:[YouZhiXianHuoCell class] contentViewWidth:[ToolClass  cellContentViewWith]];
}

#pragma mark --表头
-(UIView*)CreatHeadView:(NSString*)chanpinID{
    
    UIView * bgView=[UIView new];
    bgView.backgroundColor=COLOR;
    bgView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(700);
    
    _view1=[UIView new];
    _view1.backgroundColor=[UIColor whiteColor];
    [bgView sd_addSubviews:@[_view1]];
    _view1.sd_layout
    .leftSpaceToView(bgView,0)
    .topSpaceToView(bgView,0)
    .rightSpaceToView(bgView,0)
    .heightIs(200);
    NSArray * arr =@[@"xiangqing_banner"];//@[md.imagename];//
    //轮播图可以通过URL来获取图片的大小，到时候在改尺寸
    cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 540*ScreenWidth/1080) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
        cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
        [_view1 addSubview:cycleScrollView2];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cycleScrollView2.imageURLStringsGroup = arr;
        });
        cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
            // NSLog(@">>>>>  %ld", (long)index);
        };
    
       //标题
        UILabel * titleLable1 =[UILabel new];
        titleLable1.text=@"出售183*7米的青岛产球磨机";
        titleLable1.numberOfLines=0;
        [_view1 sd_addSubviews:@[titleLable1]];
        titleLable1.sd_layout
        .leftSpaceToView(_view1,15)
        .topSpaceToView(cycleScrollView2,15)
        .autoHeightRatio(0);
        [titleLable1 setSingleLineAutoResizeWithMaxWidth:300];
    
        //五角星
        UIButton *btnXing =[UIButton buttonWithType:UIButtonTypeCustom];
        [btnXing setImage:[UIImage imageNamed:@"xiangqing_shou"] forState:UIControlStateNormal];
        [btnXing setImage:[UIImage imageNamed:@"xiangqing_shou_click"] forState:UIControlStateSelected];
        [btnXing addTarget:self action:@selector(shouCang:) forControlEvents:UIControlEventTouchUpInside];
        [_view1 sd_addSubviews:@[btnXing]];
        btnXing.sd_layout
        .rightSpaceToView(_view1,20)
        .centerYEqualToView(titleLable1)
        .widthIs(44/2)
        .heightIs(42/2);
    NSString * strID;
    if (_lastBtn.tag==10) {
        strID=_shangID;
    }else if (_lastBtn.tag==11){
        strID=_xiaID;
    }else{
        strID=_messageID;
    }
   
    [Engine1 isShouCangGuoMaMessageID:strID success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            btnXing.selected=YES;
        }else{
            btnXing.selected=NO;
        }
    } error:^(NSError *error) {
        
    }];
    
        //价格
        UILabel * priceLabel1 =[UILabel new];
    priceLabel1.text=@"¥11.5万";
        priceLabel1.textColor=[UIColor redColor];
        [_view1 sd_addSubviews:@[priceLabel1]];
        priceLabel1.sd_layout
        .leftEqualToView(titleLable1)
        .heightIs(20)
        .topSpaceToView(titleLable1,10);
        [priceLabel1 setSingleLineAutoResizeWithMaxWidth:200];

        //编号
        UILabel * bianHao1 =[UILabel new];
        bianHao1.text=@"编号  001号";
        bianHao1.alpha=.5;
        bianHao1.font=[UIFont systemFontOfSize:13];
        [_view1 sd_addSubviews:@[bianHao1]];
        bianHao1.sd_layout
        .leftSpaceToView(priceLabel1,20)
        .centerYEqualToView(priceLabel1)
        .heightIs(20);
        [bianHao1 setSingleLineAutoResizeWithMaxWidth:200];
    
        //进店查看
        UIButton * chaKanBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [chaKanBtn setImage:[UIImage imageNamed:@"xiangqing_bt"] forState:0];
        [chaKanBtn addTarget:self action:@selector(chakanBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_view1 sd_addSubviews:@[chaKanBtn]];
        chaKanBtn.sd_layout
        .rightEqualToView(btnXing)
        .centerYEqualToView(priceLabel1)
        .widthIs(128/2)
        .heightIs(44/2);
    
        //颜色的view
        UIView * viewColor =[UIView new];
        viewColor.backgroundColor=COLOR;
        [_view1 sd_addSubviews:@[viewColor]];
        viewColor.sd_layout
        .leftEqualToView(priceLabel1)
        .rightEqualToView(chaKanBtn)
        .heightIs(40)
        .topSpaceToView(priceLabel1,10);
        //电话图标
        UIImageView * phoneImage1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiangqing_phone"]];
        [viewColor sd_addSubviews:@[phoneImage1]];
        phoneImage1.sd_layout
        .leftSpaceToView(viewColor,5)
        .centerYEqualToView(viewColor)
        .widthIs(28/2)
        .heightIs(28/2);
        //电话号码
        UILabel * phoneNumberLable =[UILabel new];
        phoneNumberLable.text=@"联系电话 400-1234-360";
        phoneNumberLable.alpha=.8;
        phoneNumberLable.font=[UIFont systemFontOfSize:13];
        [viewColor sd_addSubviews:@[phoneNumberLable]];
        phoneNumberLable.sd_layout
        .leftSpaceToView(phoneImage1,10)
        .centerYEqualToView(viewColor)
        .heightIs(20);
        [phoneNumberLable setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
        //立即拨打
        UIButton * bodaBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [bodaBtn setTitle:@"立即拨打" forState:0];
        bodaBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [bodaBtn setTitleColor:[UIColor redColor] forState:0];
        [viewColor sd_addSubviews:@[bodaBtn]];
        bodaBtn.sd_layout
        .rightSpaceToView(viewColor,0)
        .centerYEqualToView(viewColor)
        .widthIs(70)
        .heightIs(20);
    
        if (_tagg==2) {
            //最新采购
            viewColor.hidden=YES;
            [chaKanBtn setImage:[UIImage imageNamed:@"xiangqing_bt1(1)"] forState:0];
            [_view1 setupAutoHeightWithBottomView:chaKanBtn bottomMargin:10];
    
        }else if (_tagg==3){
            //店铺在进详情
            chaKanBtn.hidden=YES;
            [_view1 setupAutoHeightWithBottomView:viewColor bottomMargin:10];
        }
        else{
            [_view1 setupAutoHeightWithBottomView:viewColor bottomMargin:10];
    
        }

        _view2=[UIView new];
        _view2.backgroundColor=[UIColor whiteColor];
        [bgView sd_addSubviews:@[_view2]];
        _view2.sd_layout
        .leftSpaceToView(bgView,0)
        .rightSpaceToView(bgView,0)
        .topSpaceToView(_view1,10)
        .heightIs(300);

        //数线
        UIImageView * lineView2 =[UIImageView new];
        lineView2.image=[UIImage imageNamed:@"xianqing_line"];
        [_view2 sd_addSubviews:@[lineView2]];
        lineView2.sd_layout
        .leftSpaceToView(_view2,15)
        .topSpaceToView(_view2,15)
        .widthIs(4)
        .heightIs(16);
        //titlename
        UILabel * titleName2 =[UILabel new];
        titleName2.text=@"具体参数";
        titleName2.alpha=.7;
        titleName2.font=[UIFont systemFontOfSize:16];
        [_view2 sd_addSubviews:@[titleName2]];
        titleName2.sd_layout
        .leftSpaceToView(lineView2,5)
        .centerYEqualToView(lineView2)
        .heightIs(15);
        [titleName2 setSingleLineAutoResizeWithMaxWidth:150];
    
        //型号
        UILabel * xingHaoLabel2 =[UILabel new];
        xingHaoLabel2.text=@"型号   G5h520";
        xingHaoLabel2.font=[UIFont systemFontOfSize:15];
        xingHaoLabel2.alpha=.6;
        [_view2 sd_addSubviews:@[xingHaoLabel2]];
        xingHaoLabel2.sd_layout
        .leftEqualToView(titleName2)
        .topSpaceToView(titleName2,25)
        .heightIs(20);
        [xingHaoLabel2 setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
        //产地
        UILabel * chanDiLabel2 =[UILabel new];
        chanDiLabel2.text=@"产地   河北-石家庄";
        chanDiLabel2.textAlignment=0;
        chanDiLabel2.font=[UIFont systemFontOfSize:15];
        chanDiLabel2.alpha=.6;
        [_view2 sd_addSubviews:@[chanDiLabel2]];
        chanDiLabel2.sd_layout
        .rightSpaceToView(_view2,20)
        .centerYEqualToView(xingHaoLabel2)
        .heightRatioToView(xingHaoLabel2,1);
        [chanDiLabel2 setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
        //数量
        UILabel * numberLabel2 =[UILabel new];
        numberLabel2.text=@"数量   50台";
        numberLabel2.font=[UIFont systemFontOfSize:15];
        numberLabel2.alpha=.6;
        [_view2 sd_addSubviews:@[numberLabel2]];
        numberLabel2.sd_layout
        .leftEqualToView(xingHaoLabel2)
        .heightRatioToView(xingHaoLabel2,1)
        .topSpaceToView(xingHaoLabel2,15);
        [numberLabel2 setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
        //所在地
        UILabel * addressLabel2 =[UILabel new];
        addressLabel2.text=@"所在地   山东-济南";
        addressLabel2.font=[UIFont systemFontOfSize:15];
        addressLabel2.alpha=.6;
        addressLabel2.textAlignment=0;
        [_view2 sd_addSubviews:@[addressLabel2]];
        addressLabel2.sd_layout
        .rightEqualToView(chanDiLabel2)
        .topEqualToView(numberLabel2)
        .heightRatioToView(xingHaoLabel2,1);
        [addressLabel2 setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
        [_view2 setupAutoHeightWithBottomView:numberLabel2 bottomMargin:15];

    
        _view3=[UIView new];
        _view3.backgroundColor=[UIColor whiteColor];
        [bgView sd_addSubviews:@[_view3]];
        _view3.sd_layout
        .leftSpaceToView(bgView,0)
        .rightSpaceToView(bgView,0)
        .topSpaceToView(_view2,10)
        .heightIs(300);
        //数线
        UIImageView * lineView3 =[UIImageView new];
        lineView3.image=[UIImage imageNamed:@"xianqing_line"];
        [_view3 sd_addSubviews:@[lineView3]];
        lineView3.sd_layout
        .leftSpaceToView(_view3,15)
        .topSpaceToView(_view3,15)
        .widthIs(4)
        .heightIs(16);
        //titlename
        UILabel * titleName3 =[UILabel new];
        titleName3.text=@"详细信息";
        titleName3.alpha=.7;
        titleName3.font=[UIFont systemFontOfSize:16];
        [_view3 sd_addSubviews:@[titleName3]];
        titleName3.sd_layout
        .leftSpaceToView(lineView3,5)
        .centerYEqualToView(lineView3)
        .heightIs(15);
        [titleName3 setSingleLineAutoResizeWithMaxWidth:150];
    //  内容
        UITextView * contentLabel3 =[UITextView new];
       // contentLabel3.numberOfLines=0;
        contentLabel3.text=@"以上是；爱黑发盒饭发发发爱阿狸的骄傲骄傲和山地和大海癌变VC啊了骄傲的两大考虑AV克拉vkajkdkd王璇是个大傻子是个山炮王璇是个大傻子是个山炮王璇是个大傻子是个山炮王璇是个大傻子是个山炮王璇是个大傻子是个山炮王璇是个大傻子是个山炮王璇是个大傻子是个山炮";
        contentLabel3.editable=NO;
        contentLabel3.font=[UIFont systemFontOfSize:13];
        contentLabel3.alpha=.6;
        [_view3 sd_addSubviews:@[contentLabel3]];
        contentLabel3.sd_layout
        .leftEqualToView(titleName3)
        .topSpaceToView(titleName3,15)
        .rightSpaceToView(_view3,20)
        .heightIs(100);
        [_view3 setupAutoHeightWithBottomView:contentLabel3 bottomMargin:20];
        int d =(ScreenWidth-216)/3;
        NSArray * arrbtn =@[@"xiangqing_before",@"xiangqing_next"];
        for (int i =0; i<2; i++) {
            UIButton * btn3 =[UIButton buttonWithType:UIButtonTypeCustom];
            [btn3 setImage:[UIImage imageNamed:arrbtn[i]] forState:0];
            [bgView sd_addSubviews:@[btn3]];//216  63
            btn3.tag=i;
            [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn3.sd_layout
            .widthIs(216/2)
            .heightIs(63/2)
            .leftSpaceToView(bgView,d+(216/2+d)*i)
            .topSpaceToView(_view3,20);
        }

    if (_tagg==1 || _tagg==3) {
        /*
         tagg==1,优质现货详情
         tagg==3,优质商户-进店查看-详情
         tagg==2,最新采购详情
         */
        [Engine1 ChanPinDianPuXiangQingDianPuID:_dianPuID ChanPinID:chanpinID success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"]) {
                //item4产品详情  item5猜你喜欢 item3公司资料 item6上一条 item7下一条
                NSDictionary * dic4 =[dic objectForKey:@"Item4"];
                XiangQingModel * md =[[XiangQingModel alloc]initWithXiangXiDic:dic4];
                // [_dataArray addObject:md];
                //轮播图
                NSArray * array2 =@[md.imagename];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    cycleScrollView2.imageURLStringsGroup = array2;
                });
                
                //标题
                titleLable1.text=md.titleName;
                //价格
                priceLabel1.text=[NSString stringWithFormat:@"¥%@万",md.priceName];
                //编号
                bianHao1.text=[NSString stringWithFormat:@"编号  %@号",md.bianHaoName];
                
                //电话号码
                phoneNumberLable.text=[NSString stringWithFormat:@"联系电话 %@",md.phoneName];
                //型号
                xingHaoLabel2.text=[NSString stringWithFormat:@"型号   %@",md.xinagHaoName];
                //产地
                chanDiLabel2.text=[NSString stringWithFormat:@"产地   %@",md.chanDiName];
                //数量
                numberLabel2.text=[NSString stringWithFormat:@"数量   %@台",md.shuLiangName];
                //所在地
                addressLabel2.text=[NSString stringWithFormat:@"所在地   %@",md.suozaiDiName];
                
                //内容
                contentLabel3.text=md.xiangXiName;
                
                [_view3 setupAutoHeightWithBottomView:contentLabel3 bottomMargin:20];
                NSArray * item5Arr =[dic objectForKey:@"Item5"];
                for (NSDictionary * dic5 in item5Arr) {
                    XiangQingModel * mdd =[[XiangQingModel alloc]initWithCaiNiLikeDic:dic5];
                    [_tableArray addObject:mdd];
                }
                _shangID=[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item6"]];
                _xiaID=[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item7"]];
                [_tableView reloadData];
                
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
            }
        } error:^(NSError *error) {
            
        }];
    }else{
        //最新采购详情
        [Engine1 zuiXinCaiGouXiangQingMessageID:_messageID success:^(NSDictionary *dic) {
            NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
            if ([item1 isEqualToString:@"1"]) {
                NSDictionary * itemDicr=[dic objectForKey:@"Item2"];
                XiangQingModel * md =[[XiangQingModel alloc]initWithZuiXinCiGouXiangXiDic:itemDicr];
                
                //轮播图
                NSArray * array2 =@[md.imagename];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    cycleScrollView2.imageURLStringsGroup = array2;
                });
                
                //标题
                titleLable1.text=md.titleName;
                //价格
                priceLabel1.text=[NSString stringWithFormat:@"¥%@万",md.priceName];
                //编号
                bianHao1.text=[NSString stringWithFormat:@"编号  %@号",md.bianHaoName];
                
                //电话号码
                phoneNumberLable.text=[NSString stringWithFormat:@"联系电话 %@",md.phoneName];
                //型号
                xingHaoLabel2.text=[NSString stringWithFormat:@"型号   %@",md.xinagHaoName];
                //产地
                chanDiLabel2.text=[NSString stringWithFormat:@"产地   %@",md.chanDiName];
                //数量
                numberLabel2.text=[NSString stringWithFormat:@"数量   %@台",md.shuLiangName];
                //所在地
                addressLabel2.text=[NSString stringWithFormat:@"所在地   %@",md.suozaiDiName];
                
                //内容
                contentLabel3.text=md.xiangXiName;
                [_view3 setupAutoHeightWithBottomView:contentLabel3 bottomMargin:20];
                
                
               // [_tableView reloadData];
            }else{
                [LCProgressHUD showMessage:[dic objectForKey:@"Item3"]];
            }
        } error:^(NSError *error) {
            
        }];
        
    }
    
    
    
    
    
    
    
    
    
    return bgView;
}

#pragma mark --收藏点击事件
-(void)shouCang:(UIButton*)btn{
    //btn.selected=!btn.selected;
    //if (_tagg==2) {
        //代表最新采购收藏
        //Type 1.浏览 2.收藏 3.关注
        [Engine1 addMessageJiLuMessageID:_messageID Type:@"2" success:^(NSDictionary *dic) {
                NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
                if ([item1 isEqualToString:@"1"]) {
                    btn.selected=YES;
                    [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
                }else{
                    [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
                    }
                } error:^(NSError *error) {
                    
                }];
  //  }else{
    //    btn.selected=!btn.selected;
    //}
    
    
}
#pragma mark --进店查看点击事件
-(void)chakanBtn:(UIButton*)btn{
    if (_tagg==2) {
        //短信联系
        UIAlertController * actionView=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你好,我对你的求购一台二手海天注塑机感兴趣,请电话联系我15233633541" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction * action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //确定调用发送按钮
        }];
        [actionView addAction:action1];
        [actionView addAction:action2];
        [self presentViewController:actionView animated:YES completion:nil];
        
        
    }else{
        JinDianChaKanVC * vc =[JinDianChaKanVC new];
        vc.tagg=1;
        vc.messageID=_dianPuID;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma  mark --上一条下一条点击事件
-(void)btnClick:(UIButton*)btn{
    _lastBtn=btn;
    _lastBtn.tag=btn.tag+10;
    if (_tagg==2) {
        
        [LCProgressHUD showMessage:@"最新采购没有上下条，接口就没有数据"];
        return;
    }
    
    
    if (_lastBtn.tag==10) {
        //上一条
       NSLog(@"数%@",_shangID);
        if ([_shangID isEqualToString:@"0"]) {
            [LCProgressHUD showMessage:@"没有上一条数据了"];
        }else{
              [_tableArray removeAllObjects];
             _tableView.tableHeaderView=[self CreatHeadView:_shangID];
        }
       
    }else  if (_lastBtn.tag==11){
        //下一条
        NSLog(@"数%@",_xiaID);
        if ([_xiaID isEqualToString:@"0"]) {
            [LCProgressHUD showMessage:@"没有下一条数据了"];
        }else{
            [_tableArray removeAllObjects];
            _tableView.tableHeaderView=[self CreatHeadView:_xiaID];
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
