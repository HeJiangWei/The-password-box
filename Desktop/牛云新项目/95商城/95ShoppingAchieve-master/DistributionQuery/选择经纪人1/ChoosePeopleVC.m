//
//  ChoosePeopleVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ChoosePeopleVC.h"
#import "ChoosePeopleCell.h"
#import "ChoosePeopleModel.h"
@interface ChoosePeopleVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIButton * lastBtn;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation ChoosePeopleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"选择经济人";
    _dataArray=[NSMutableArray new];
    [self rightBtn];
    [self getJingJiPeople];
    [self CreatTableView];
}

#pragma mark --获取经纪人
-(void)getJingJiPeople{
    [Engine1 huoQuJingJiRenWithHangYeID:@"0" success:^(NSDictionary *dic)
    {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * item3Arr =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in item3Arr) {
                ChoosePeopleModel * md =[[ChoosePeopleModel alloc]initWithChoosePeople:dicc];
                [_dataArray addObject:md];
            }
            [_tableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}


#pragma mark --右按钮
-(void)rightBtn{
    //搜索按钮
   UIButton* _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setTitle:@"确定" forState:0];
    [_rightBtn setTitleColor:[UIColor redColor] forState:0];
    [_rightBtn addTarget:self action:@selector(queDingBtn:) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    _rightBtn.frame=CGRectMake(0, 0, 50, 15);
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItems=@[rightBtn];
}
#pragma mark --创建tableview
-(void)CreatTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    }
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[UIView new];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID =[NSString stringWithFormat:@"%lu%lu",indexPath.section,indexPath.row];
    ChoosePeopleCell * cell =[ChoosePeopleCell cellWithTableView:tableView CellID:cellID];
    cell.model=_dataArray[indexPath.row];
    cell.duiGouBtn.tag=indexPath.row;
    [cell.duiGouBtn addTarget:self action:@selector(duiBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (cell.duiGouBtn.tag==0) {
        cell.duiGouBtn.selected=YES;
        _lastBtn= cell.duiGouBtn;
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ChoosePeopleModel * md=_dataArray[indexPath.row];
//    self.peopleIDBlock(md.jingJiIdd);
}
#pragma mark --对勾
-(void)duiBtn:(UIButton*)btn{
    _lastBtn.selected=!_lastBtn.selected;
    btn.selected=!btn.selected;
    _lastBtn=btn;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)queDingBtn:(UIButton*)btn{
    NSLog(@"btn.tag=%lu",_lastBtn.tag);
    ChoosePeopleModel * md=_dataArray[_lastBtn.tag];
    self.peopleIDBlock(md.jingJiIdd);
    [self.navigationController popViewControllerAnimated:YES];
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
