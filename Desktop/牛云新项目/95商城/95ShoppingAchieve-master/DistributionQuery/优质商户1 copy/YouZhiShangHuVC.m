//
//  YouZhiShangHuVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "YouZhiShangHuVC.h"
#import "YouZhiShangHuCell.h"
#import "LeftMyAdressCell.h"
#import "RightMyAddressCell.h"
#import "JinDianChaKanVC.h"
#import "CityModel.h"
#import "HangYeModel.h"
#import "HomeModel.h"
@interface YouZhiShangHuVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UITableView*leftTabelView;
@property(nonatomic,strong)UITableView*rightTabelView;
@property(nonatomic,strong)UIButton * bgview;
@property(nonatomic,strong)UIButton * button1;
@property(nonatomic,strong)UIButton * button2;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int AAA;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
//顶级数组
@property(nonatomic,strong)NSMutableArray * shengArr;
@property(nonatomic,strong)NSMutableArray * cityArr;
@property(nonatomic,assign)NSInteger btntag;//用来区分左右按钮
@property(nonatomic,copy)NSString * jiLuCityCode;//用来记录选择好的城市ID
@property(nonatomic,copy)NSString * jiLuHangYeCode;//用来记录选择好的行业ID
@end

@implementation YouZhiShangHuVC

-(void)viewWillAppear:(BOOL)animated{
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.title=@"优质商户";
    _shengArr=[NSMutableArray new];
    _cityArr=[NSMutableArray new];
    [self CreatTableView];
    NSMutableArray* titleArr =[[NSMutableArray alloc]initWithObjects:@"地区",@"行业", nil];
    _bgview=[[UIButton alloc]init];
    _bgview.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    _bgview.backgroundColor=[UIColor blackColor];
    [_bgview addTarget:self action:@selector(bgViewBtn) forControlEvents:UIControlEventTouchUpInside];
    _bgview.alpha=.5;
   
    [self CreatBtnTitle:titleArr];
}
#pragma mark --创建下拉的Button
-(void)CreatBtnTitle:(NSMutableArray*)arr{
    CGFloat k =(ScreenWidth)/arr.count;///3-20;
    CGFloat g =45;
    
    for (int i = 0; i<arr.count; i++) {
        UIButton *  menuBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.view sd_addSubviews:@[menuBtn]];
        menuBtn.sd_layout
        .leftSpaceToView(self.view,k*i)
        .topSpaceToView(self.view,5+64)
        .widthIs(k)
        .heightIs(g);
        menuBtn.backgroundColor=[UIColor whiteColor];
        [menuBtn setTitleColor:[UIColor blackColor] forState:0];
        menuBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        menuBtn.tag=i;
        [menuBtn setImage:[UIImage imageNamed:@"xia123"] forState:UIControlStateNormal];
        [menuBtn addTarget:self action:@selector(butTitleClink:) forControlEvents:UIControlEventTouchUpInside];
        [menuBtn setTitle:arr[i] forState:0];
        [menuBtn setImage:[UIImage imageNamed:@"shang123"] forState:UIControlStateSelected];
        [menuBtn setImageEdgeInsets:UIEdgeInsetsMake(0,k-20, 0, 0)];
        [menuBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [menuBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
    }
    
    
}

#pragma mark --获取网络数据
-(void)shangHuDataPage:(NSString*)page HangYe:(NSString*)hangYe CityCode:(NSString*)citycode{
    [Engine1 GetYouZhiShangHuPage:page HangYeID:hangYe CityCode:citycode  GuanJianZi:[self stingTextCityID:_ziText] success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            if ([dic objectForKey:@"Item3"]==[NSNull null]) {
                [LCProgressHUD showMessage:@"Item3没有数据"];
            }else{
                NSArray * item3Arr =[dic objectForKey:@"Item3"];
                 NSMutableArray * array2=[NSMutableArray new];
                for (NSDictionary * dicc in item3Arr) {
                    HomeModel * md =[[HomeModel alloc]initWithYouZhiShangHuDic:dicc];
                    [array2 addObject:md];
                }
                if (self.myRefreshView == _tableView.header) {
                    _dataArray = array2;
                    _tableView.footer.hidden = _dataArray.count==0?YES:NO;
                }else if(self.myRefreshView == _tableView.footer){
                    [_dataArray addObjectsFromArray:array2];
                }
            }
            
            [_tableView reloadData];
            [_myRefreshView  endRefreshing];
            
            
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
             [_myRefreshView endRefreshing];
        }
    } error:^(NSError *error) {
         [_myRefreshView endRefreshing];
    }];
}


#pragma mark --topBtn点击状态
-(void)butTitleClink:(UIButton*)btn{
    btn.selected=!btn.selected;
     _btntag=btn.tag;
    if (btn.tag==0) {
        //点击的是第一个
        if (btn.selected==YES) {
             [self shengFenData];
            _tableView.scrollEnabled=NO;
            [_tableView setContentOffset:CGPointZero animated:NO];
            [_tableView addSubview:_bgview];
            [_rightTabelView removeFromSuperview];
            [_leftTabelView removeFromSuperview];
            _button2.selected=NO;
            [self CreatLeftTableVeiw];
        }else{
            [self dissmiss];
        }
        
        _button1=btn;
        
    }
    else{
        //点击的是第3个
        if (btn.selected==YES) {
             [self getHangYeAll];
            _tableView.scrollEnabled=NO;
            [_tableView setContentOffset:CGPointZero animated:NO];
            [_tableView addSubview:_bgview];
            [_leftTabelView removeFromSuperview];
            [_rightTabelView removeFromSuperview];
            _button1.selected=NO;
            [self CreatLeftTableVeiw];
        }else{
            [self dissmiss];
        }
        _button2=btn;
    }
}

#pragma mark --获取全国省份
-(void)shengFenData{
    [_shengArr removeAllObjects];
    [Engine1 getShengJiDiQusuccess:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * arr =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in arr)
            {
                CityModel * model =[[CityModel alloc]initWithShengDic:dicc];
                [_shengArr addObject:model];
            }
            
            [_leftTabelView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark --获取所有行业
-(void)getHangYeAll{
    [_shengArr removeAllObjects];
    [Engine1 getHangYeChanPinFenLeisuccess:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * arr =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in arr) {
                HangYeModel * md =[[HangYeModel alloc]initWithHangYeAllDic:dicc];
                [_shengArr addObject:md];
            }
            [_leftTabelView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}

#pragma mark --灰色按钮点击取消
-(void)bgViewBtn{
    [self dissmiss];
    _button1.selected=NO;
    _button2.selected=NO;
}

#pragma mark --创建左边表格
-(void)CreatLeftTableVeiw{
    
    _leftTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+51, ScreenWidth/2, ScreenHeight/1.5) style:UITableViewStylePlain];
    _leftTabelView.dataSource=self;
    _leftTabelView.delegate=self;
    _leftTabelView.tableFooterView=[UIView new];
    _leftTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_leftTabelView];
    
}
#pragma mark --创建第二个表格
-(void)CreatRightTableView:(CGFloat)kuan Xzhou:(CGFloat)x Gzhou:(CGFloat)g{
    [_rightTabelView removeFromSuperview];
    _rightTabelView=nil;
    if (_rightTabelView==nil) {
        _rightTabelView=[[UITableView alloc]initWithFrame:CGRectMake(x, 64+51,kuan, g) style:UITableViewStylePlain];
        _rightTabelView.backgroundColor=COLOR;
        _rightTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _rightTabelView.dataSource=self;
        _rightTabelView.delegate=self;
        [self.view addSubview:_rightTabelView];
    }
    
}

#pragma mark --创建表
-(void)CreatTableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+51, ScreenWidth, ScreenHeight-64-51) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableFooterView=[UIView new];
    [self.view addSubview:_tableView];
    //刷新操作
    __weak typeof (self) weakSelf =self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"往下拉了");
        _AAA=1;
        weakSelf.myRefreshView = weakSelf.tableView.header;
        [self shangHuDataPage:[NSString stringWithFormat:@"%d",_AAA] HangYe:[self stingTextCityID:_jiLuHangYeCode] CityCode:[self stingTextCityID:_jiLuCityCode]];
    }];
    
    // 马上进入刷新状态
    [_tableView.header beginRefreshing];
    //..上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.footer;
        NSLog(@"往上拉了加载更多");
        _AAA=_AAA+1;
        
        [self shangHuDataPage:[NSString stringWithFormat:@"%d",_AAA] HangYe:[self stingTextCityID:_jiLuHangYeCode] CityCode:[self stingTextCityID:_jiLuCityCode]];
    }];
    _tableView.footer.hidden = YES;

    
}
-(NSString*)stingTextCityID:(NSString*)cityId{
    if (cityId) {
        return cityId;
    }else{
        return @"0";
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_leftTabelView) {
        return _shengArr.count;
    }else if (tableView==_rightTabelView){
        return _cityArr.count;
    }else{
        return _dataArray.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==_leftTabelView) {
        
        LeftMyAdressCell * cell1 =[LeftMyAdressCell cellWithTableView:tableView];
        cell1.textLabel.textAlignment=1;
        cell1.textLabel.font=[UIFont systemFontOfSize:15];
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (_btntag==0) {
            //点击的是城市给城市赋值
            CityModel * md =_shengArr[indexPath.row];
            cell1.textLabel.text=md.shengName;
        }else if (_btntag==1){
            //点击的是行业，给行业赋值
            HangYeModel * md =_shengArr[indexPath.row];
            cell1.textLabel.text=md.HYname;
        }

        return cell1;
    }else if (tableView==_rightTabelView)
    {
        RightMyAddressCell * cell1 =[RightMyAddressCell cellWithTableView:tableView];
        cell1.textLabel.textAlignment=1;
        cell1.textLabel.font=[UIFont systemFontOfSize:15];
        if (_btntag==0) {
            CityModel * md =_cityArr[indexPath.row];
            cell1.textLabel.text=md.cityName;
        }
        else if (_btntag==1){
            HangYeModel * md =_cityArr[indexPath.row];
            cell1.textLabel.text=md.HYname;
        }
        
        return cell1;
    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
        YouZhiShangHuCell * cell =[YouZhiShangHuCell cellWithTableView:tableView CellID:CellIdentifier];
        cell.model=_dataArray[indexPath.row];
        return cell;

    }
    
    
}
#pragma mark --表格的点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_leftTabelView) {
        [self CreatRightTableView:ScreenWidth-ScreenWidth/2 Xzhou:ScreenWidth/2 Gzhou:ScreenHeight/1.5];
        if (_btntag==0) {
            CityModel * mdd =_shengArr[indexPath.row];
            [self shengWithCity:mdd];
        }else if (_btntag==1){
            HangYeModel * md =_shengArr[indexPath.row];
            [self genJuIddGetHangYe:md];
        }

    }else if (tableView==_rightTabelView){
        if (_btntag==0) {
            CityModel * mdd=_cityArr[indexPath.row];
             _jiLuCityCode=mdd.cityCode;
            _button1.selected=NO;
            [_button1 setTitle:mdd.cityName forState:0];
            _button1.titleLabel.font=[UIFont systemFontOfSize:14];
            _AAA=1;
            [_dataArray removeAllObjects];
            [self shangHuDataPage:[NSString stringWithFormat:@"%d",_AAA] HangYe:[self stingTextCityID:_jiLuHangYeCode] CityCode:[self stingTextCityID:_jiLuCityCode]];
        }
        else if (_btntag==1){
            HangYeModel * mdd =_cityArr[indexPath.row];
              _jiLuHangYeCode=mdd.HYidd;
            _button2.selected=NO;
            [_button2 setTitle:mdd.HYname forState:0];
            _button2.titleLabel.font=[UIFont systemFontOfSize:14];
             _AAA=1;
            [_dataArray removeAllObjects];
            [self shangHuDataPage:[NSString stringWithFormat:@"%d",_AAA] HangYe:[self stingTextCityID:_jiLuHangYeCode] CityCode:[self stingTextCityID:_jiLuCityCode]];
        }
        
        [self dissmiss];
    }else{
        //优质商户详情页(和进店查看一样)
        HomeModel * mdd =_dataArray[indexPath.row];
        JinDianChaKanVC * vc =[JinDianChaKanVC new];
        vc.tagg=2;
        vc.messageID=mdd.messageID;//店铺ID
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark --根据省去解析市级
-(void)shengWithCity:(CityModel*)mdd{
    [_cityArr removeAllObjects];
    [Engine1 getCityWithShengCode:mdd.shengCode success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * cityA =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in cityA)
            {
                CityModel * mmd =[[CityModel alloc]initWithCityDic:dicc];
                [_cityArr addObject:mmd];
            }
            
            [_rightTabelView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark --根据ID获取行业分类
-(void)genJuIddGetHangYe:(HangYeModel*)md{
    [_cityArr removeAllObjects];//把之前的城市清楚，换成行业数据
    [Engine1 getHangYeWithID:md.HYidd success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * arr =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in arr) {
                HangYeModel * md =[[HangYeModel alloc]initWithHangYeAllDic:dicc];
                [_cityArr addObject:md];
            }
            [_rightTabelView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_leftTabelView) {
        return 44;
    }else if (tableView==_rightTabelView){
        return 44;
    }else{
        return 95;
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
-(void)dissmiss{
    _tableView.scrollEnabled=YES;
    [_bgview removeFromSuperview];
    [_leftTabelView removeFromSuperview];
    [_rightTabelView removeFromSuperview];
}
@end
