//
//  TongHangShangPinVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "TongHangShangPinVC.h"
#import "YouZhiXianHuoCell.h"
@interface TongHangShangPinVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int AAA;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)UIButton * selectAllBtn;//全选
@property(nonatomic,strong)UIButton * deleteBtn;//删除
@property (nonatomic,strong)NSMutableArray *deleteArr;//盛放删除的数据
@property(nonatomic,assign)NSInteger indexRow;
@end

@implementation TongHangShangPinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray=[NSMutableArray new];
    _deleteArr=[NSMutableArray new];
    [self.rightBtn addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self CreatTableView];
     [self CreatAllselectBtn];
    
}
#pragma mark --创建全选和删除
-(void)CreatAllselectBtn{
    _selectAllBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _selectAllBtn.frame = CGRectMake(0, ScreenHeight-40, ScreenWidth/2.5, 40);
    _selectAllBtn.backgroundColor=[UIColor redColor];
    [_selectAllBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [_selectAllBtn addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _selectAllBtn.hidden=YES;
    _selectAllBtn.titleLabel.font=[UIFont systemFontOfSize:16];

    [self.view sd_addSubviews:@[_selectAllBtn]];
    _selectAllBtn.sd_layout
    .leftSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .widthIs(ScreenWidth/2.5)
    .heightIs(40);

    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.backgroundColor=[UIColor redColor];
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    _deleteBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _deleteBtn.hidden=YES;
    [_deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view sd_addSubviews:@[_deleteBtn]];
    _deleteBtn.sd_layout
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .widthIs(ScreenWidth/2.5)
    .heightIs(40);
    
}
//删除按钮点击事件
- (void)deleteClick:(UIButton *)button {
    
    if (self.tableView.editing) {
        //删除表的数据
        
        for (int i = 0; i < self.deleteArr.count; i ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            HomeModel * md =_deleteArr[indexPath.row];
            [Engine1 deleteMessageID:md.messageID success:^(NSDictionary *dic) {
                NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
                if ([item1 isEqualToString:@"1"]) {
                    [self.dataArray removeObjectsInArray:self.deleteArr];
                    [self.tableView reloadData];
                }else{
                    [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
                }
            } error:^(NSError *error) {
                
            }];
            NSLog(@"我擦%@",md.messageID);
        }
        //
    }
    else return;
}
#pragma mark --点击右上角编辑
-(void)selectedBtn:(UIButton*)button{
    _deleteBtn.enabled = YES;
    //支持同时选中多行
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.editing = !self.tableView.editing;
    if (self.tableView.editing) {
        [button setTitle:@"完成" forState:UIControlStateNormal];
        _selectAllBtn.hidden=NO;
        _deleteBtn.hidden=NO;
    }else{
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        [self.deleteArr removeAllObjects];
        _selectAllBtn.hidden=YES;
        _deleteBtn.hidden=YES;
    }
  
}

//全选
- (void)selectAllBtnClick:(UIButton *)button {
    
    for (int i = 0; i < self.dataArray.count; i ++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    self.deleteArr=self.dataArray;
}
//是否可以编辑  默认的时YES
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//选择编辑的方式,按照选择的方式对表进行处理
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
    
}
//选择你要对表进行处理的方式  默认是删除方式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

//选中时将选中行的在self.dataArray 中的数据添加到删除数组self.deleteArr中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.deleteArr addObject:[self.dataArray objectAtIndex:indexPath.row]];
    
}
//取消选中时 将存放在self.deleteArr中的数据移除
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {
    _indexRow=indexPath.row;
    [self.deleteArr removeObject:[self.dataArray objectAtIndex:indexPath.row]];
}


-(void)getQiuGouData:(NSString*)page{
    [Engine1 getMessageJiLuType:@"2" Page:page PageSize:@"10" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            if ([dic objectForKey:@"Item3"]==[NSNull null] ||[[dic objectForKey:@"Item3"] count]==0 ) {
                [LCProgressHUD showMessage:@"Item3为空"];
            }else{
                NSArray * item3Ar =[dic objectForKey:@"Item3"];
                NSMutableArray * array2=[NSMutableArray new];
                for (NSDictionary * dicc in item3Ar) {
                    HomeModel * md =[[HomeModel alloc]initWithCaiGouDic:dicc];
                    [array2 addObject:md];
                }
                
                if (self.myRefreshView == _tableView.header) {
                    _dataArray = array2;
                    _tableView.footer.hidden = _dataArray.count==0?YES:NO;
                }else if(self.myRefreshView == _tableView.footer){
                    [_dataArray addObjectsFromArray:array2];
                }
            }
            [_myRefreshView  endRefreshing];
            [_tableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
            [_myRefreshView  endRefreshing];
        }
    } error:^(NSError *error) {
        [_myRefreshView  endRefreshing];
    }];
}


#pragma mark --创建表
-(void)CreatTableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+50, ScreenWidth, ScreenHeight-64-50) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableFooterView=[UIView new];
    _tableView.backgroundColor=COLOR;
    [self.view addSubview:_tableView];
    //刷新操作
    __weak typeof (self) weakSelf =self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"往下拉了");
        _AAA=1;
        weakSelf.myRefreshView = weakSelf.tableView.header;
        [self getQiuGouData:[NSString stringWithFormat:@"%d",_AAA]];
    }];
    
    // 马上进入刷新状态
    [_tableView.header beginRefreshing];
    //..上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.footer;
        NSLog(@"往上拉了加载更多");
        _AAA=_AAA+1;//网上拉第一下的时候 展示的应该是第二页数据
        NSLog(@"页数%d",_AAA);
        [self getQiuGouData:[NSString stringWithFormat:@"%d",_AAA]];
    }];
    _tableView.footer.hidden = YES;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    YouZhiXianHuoCell * cell =[YouZhiXianHuoCell cellWithTableView:tableView CellID:CellIdentifier];
    cell.chaKanBtn.sd_layout
    .widthIs(220/2)
    .heightIs(23);
    [cell.chaKanBtn setBackgroundImage:[UIImage imageNamed:@"shoucnag_phone-1"] forState:0];
    [cell.chaKanBtn setTitle:@"4000238438" forState:0];
    cell.chaKanBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [cell.chaKanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
    [cell.chaKanBtn setTitleColor:[UIColor redColor] forState:0];
    cell.chaKanBtn.titleLabel.font=[UIFont systemFontOfSize:13];
   // [cell.chaKanBtn addTarget:self action:@selector(chaKan:) forControlEvents:UIControlEventTouchUpInside];
    cell.model=_dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row]keyPath:@"model" cellClass:[YouZhiXianHuoCell class] contentViewWidth:[ToolClass  cellContentViewWith]];
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
