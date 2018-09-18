//
//  AllShangPinVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "AllShangPinVC.h"
#import "JinDianChaKanCell.h"
#import "JinDianModel.h"
#import "XiangQingVC.h"
@interface AllShangPinVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int AAA;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@end

@implementation AllShangPinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
   
    if (_tagg==11) {
        self.title=@"所有商品";
    }else if (_tagg==12){
        self.title=@"新品上架";
    }else if (_tagg==13){
        self.title=@"经典旧货";
    }else if (_tagg==14){
        self.title=@"优质好货";
    }
    [self CreatTabelView];
}

-(void)dataShuJuPage:(NSString*)page{
    [Engine1 dianPuChanPinMessageID:_messageID Cid:[NSString stringWithFormat:@"%lu",_cidd] Page:page success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * item3Arr =[dic objectForKey:@"Item3"];
            NSMutableArray * array2 =[NSMutableArray new];
            for (NSDictionary * dicc in item3Arr) {
                JinDianModel * model =[[JinDianModel alloc]initWithDiQuDic:dicc];
                //此时md.meesageID才是产品ID，，，_messageID是店铺ID
                [array2 addObject:model];
            }
            if (self.myRefreshView ==_tableView.header) {
                _dataArray=array2;
                _tableView.footer.hidden=_dataArray.count==0?YES:NO;
            }else if (self.myRefreshView == _tableView.footer){
                 [_dataArray addObjectsFromArray:array2];
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

-(void)CreatTabelView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=COLOR;
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    JinDianChaKanCell * cell =[JinDianChaKanCell cellWithTableView:tableView CellID:CellIdentifier];
    cell.chaKanBtn.tag=indexPath.row;
    //[cell.chaKanBtn addTarget:self action:@selector(chaKan:) forControlEvents:UIControlEventTouchUpInside];
    cell.chaKanBtn.hidden=YES;
    cell.model=_dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JinDianModel * md =_dataArray[indexPath.row];
    XiangQingVC * vc =[XiangQingVC new];
    vc.tagg=3;
    vc.messageID=md.messageID;
    vc.dianPuID=_messageID;
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [_tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row]keyPath:@"model" cellClass:[JinDianChaKanCell class] contentViewWidth:[ToolClass  cellContentViewWith]];
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
