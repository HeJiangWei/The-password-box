//
//  ShangXinVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/17.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ShangXinVC.h"
#import "ShangXinModel.h"
@interface ShangXinVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int AAA;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@end

@implementation ShangXinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self dataShuJuPage:@"1"];
    [self CreatTabelView];
    
}
-(void)dataShuJuPage:(NSString*)page{
    [Engine1 huoQuZiXunListViewCid:@"2" YeShuPage:page success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * item3 =[dic objectForKey:@"Item3"];
            NSMutableArray * array2 =[NSMutableArray new];
            for (NSDictionary *dicc in item3) {
                ShangXinModel * model =[[ShangXinModel alloc]initWithShangXinDic:dicc];
                [array2 addObject:model];
            }
            if (self.myRefreshView == _tableView.header) {
                _dataArray = array2;
                _tableView.footer.hidden = _dataArray.count==0?YES:NO;
            }else if(self.myRefreshView == _tableView.footer){
                [_dataArray addObjectsFromArray:array2];
            }
        
        
        [_tableView reloadData];
        [_myRefreshView  endRefreshing];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
             [_myRefreshView  endRefreshing];
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark --创建表
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,64+50, ScreenWidth, ScreenHeight-64-50) style:UITableViewStylePlain];
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
        [self dataShuJuPage:[NSString stringWithFormat:@"%d",_AAA]];
    }];
    
    // 马上进入刷新状态
    [_tableView.header beginRefreshing];
    //..上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.footer;
        NSLog(@"往上拉了加载更多");
        _AAA=_AAA+1;
         [self dataShuJuPage:[NSString stringWithFormat:@"%d",_AAA]];
        
    }];
    _tableView.footer.hidden = YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel * nameLabel =[UILabel new];
        nameLabel.tag=1;
        [cell sd_addSubviews:@[nameLabel]];
        UILabel * timeLabel =[UILabel new];
        timeLabel.tag=2;
        [cell sd_addSubviews:@[timeLabel]];
        
    }
    UILabel * nameLabel =(UILabel*)[cell viewWithTag:1];
    nameLabel.font=[UIFont systemFontOfSize:16];
    UILabel * timeLabel =(UILabel*)[cell viewWithTag:2];
    timeLabel.alpha=.6;
    timeLabel.font=[UIFont systemFontOfSize:14];
    ShangXinModel * md =_dataArray[indexPath.row];
    nameLabel.text=md.title;//@"1234";
    timeLabel.text=md.time;
    nameLabel.sd_layout
    .leftSpaceToView(cell,15)
    .topSpaceToView(cell,10)
    .rightSpaceToView(cell,15)
    .heightIs(20);
    
    timeLabel.sd_layout
    .leftEqualToView(nameLabel)
    .topSpaceToView(nameLabel,5)
    .heightIs(20);
    [timeLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
