//
//  FuWuChongZhiZhenVC.m
//  DistributionQuery
//
//  Created by Macx on 16/12/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "FuWuChongZhiZhenVC.h"
#import "FuWuChongZhiZhenCell.h"
#import "FuWuChongZhiVC.h"
@interface FuWuChongZhiZhenVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tabelView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation FuWuChongZhiZhenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"服务充值";
   

    NSDictionary * dic1 =@{@"image1":@"service_ms",
                           @"title1":@"短信充值",
                           @"content1":@"70字为一条,超出70字按两条信息扣费。",
                           @"btn1":@"service_right-1"};
    NSDictionary * dic2 =@{@"image1":@"service_ph",
                           @"title1":@"400充值",
                           @"content1":@"认证成功后，系统赠送20分钟,可以在我的服务中查询",
                           @"btn1":@"service_right-1"};
    NSDictionary * dic3 =@{@"image1":@"service_zd",
                           @"title1":@"置顶充值",
                           @"content1":@"置顶充值后,信息可以置顶,让更多人看到",
                           @"btn1":@"service_right-1"};
    NSDictionary * dic4 =@{@"image1":@"service_money",
                           @"title1":@"资费说明",
                           @"content1":@"点击查看短信、400、置顶费用说明",
                           @"btn1":@"sv_chakan"};
    
     _dataArr=[[NSMutableArray alloc]initWithObjects:dic1,dic2,dic3,dic4, nil];
    
    [self CreatTabelView];
}
-(void)CreatTabelView{
    if (!_tabelView) {
        _tabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    }
    _tabelView.dataSource=self;
    _tabelView.delegate=self;
    _tabelView.backgroundColor=COLOR;
    _tabelView.tableFooterView=[UIView new];
    [self.view addSubview:_tabelView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString * cellID =[NSString stringWithFormat:@"%lu%lu",indexPath.section,indexPath.row];
      FuWuChongZhiZhenCell * cell =[FuWuChongZhiZhenCell cellWithTableView:tableView CellID:cellID];
    cell.dic=_dataArr[indexPath.row];
    cell.chongZhiBtn.tag=indexPath.row;
    [cell.chongZhiBtn addTarget:self action:@selector(chongZhiButton:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


-(void)chongZhiButton:(UIButton*)btn{
    if (btn.tag==0 || btn.tag==1) {
        FuWuChongZhiVC * vc =[FuWuChongZhiVC new];
        vc.tagg=btn.tag;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [LCProgressHUD showMessage:@"此功能尚未开通,敬请期待~"];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 || indexPath.row==1) {
        FuWuChongZhiVC * vc =[FuWuChongZhiVC new];
        vc.tagg=indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [LCProgressHUD showMessage:@"此功能尚未开通,敬请期待~"];
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 120;
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
