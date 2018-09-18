//
//  HangYeVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "HangYeVC.h"
#import "LeftMyAdressCell.h"
#import "RightMyAddressCell.h"
#import "HangYeModel.h"
@interface HangYeVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView*leftTabelView;
@property(nonatomic,retain)UITableView*rightTabelView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)NSMutableArray * erJiArray;
@end

@implementation HangYeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"经营行业";
    _dataArray=[NSMutableArray new];
    _erJiArray=[NSMutableArray new];
    [self CreatLeftTableVeiw];
    [self getAllHangYe];
}
#pragma mark --创建左表
-(void)CreatLeftTableVeiw{
    _leftTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/2.5, ScreenHeight-64) style:UITableViewStylePlain];
    _leftTabelView.dataSource=self;
    _leftTabelView.delegate=self;
    _leftTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_leftTabelView];
    
}
#pragma mark --创建右表
-(void)CreatRightTableView{
    _rightTabelView=nil;
    if (_rightTabelView==nil) {
        _rightTabelView=[[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth/2.5, 0,ScreenWidth- ScreenWidth/2.5, ScreenHeight-64) style:UITableViewStylePlain];
    }
    _rightTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _rightTabelView.dataSource=self;
    _rightTabelView.delegate=self;
    [self.view addSubview:_rightTabelView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_leftTabelView) {
        return _dataArray.count;
    }else {
        return _erJiArray.count;
    }
}
#pragma mark --表的展示
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =nil;
    
    if (tableView==_leftTabelView) {
        cell =[LeftMyAdressCell cellWithTableView:tableView];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        HangYeModel * md=_dataArray[indexPath.row];
        cell.textLabel.text=md.HYname;
        
    }else {
        cell =[RightMyAddressCell cellWithTableView:tableView];
        HangYeModel * md=_erJiArray[indexPath.row];
        cell.textLabel.text=md.HYname;
        cell.textLabel.textAlignment=1;
        
    }
    
    
    cell.textLabel.font=[UIFont systemFontOfSize:13];
    cell.textLabel.textAlignment=0;

    return cell;
}
#pragma mark --表的点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==_leftTabelView) {
        [self CreatRightTableView];
        [_erJiArray removeAllObjects];
        HangYeModel * md=_dataArray[indexPath.row];
        [self genJuIddGetHangYe:md];
    }else{
         HangYeModel * md=_erJiArray[indexPath.row];
         self.hangYeNameCidBlock(md.HYname,md.HYidd);
         [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark --获取所有行业
-(void)getAllHangYe{
    [_dataArray removeAllObjects];
    [Enginejw0803 getHangYeChanPinFenLeisuccess:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * arr =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in arr) {
                HangYeModel * md =[[HangYeModel alloc]initWithHangYeAllDic:dicc];
                [_dataArray addObject:md];
            }
            [_leftTabelView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark --根据ID获取行业分类
-(void)genJuIddGetHangYe:(HangYeModel*)md{
    [_erJiArray removeAllObjects];
    [Enginejw0803 getHangYeWithID:md.HYidd success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * arr =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in arr) {
                HangYeModel * md =[[HangYeModel alloc]initWithHangYeAllDic:dicc];
                [_erJiArray addObject:md];
            }
            [_rightTabelView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
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
