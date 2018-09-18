//
//  GuanYu95VC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "GuanYu95VC.h"

@interface GuanYu95VC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * dexArray;
@end

@implementation GuanYu95VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"关于95";
    self.automaticallyAdjustsScrollViewInsets=NO;
    _dataArray=[[NSMutableArray alloc]initWithObjects:@"版本",@"客服热线",@"企业邮箱", nil];
   // _dexArray=[[NSMutableArray alloc]initWithObjects:@"v1.0",@"400-365-195",@"fuwu@hs95.com", nil];
    _dexArray=[NSMutableArray new];
    [self guanYuData];
    [self CreatTableView];
}
-(void)guanYuData{
    [Engine1 getBanBenMessagesuccess:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSDictionary * dicc =[dic objectForKey:@"Item3"];
            [_dexArray addObject:[dicc objectForKey:@"A_Version"]];
            [_dexArray addObject:[dicc objectForKey:@"A_Mail"]];
            [_dexArray addObject:[dicc objectForKey:@"A_Web"]];
            
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

-(UIView*)tableViewHeadView{
    UIView * view =[UIView new];
   // view.backgroundColor=[UIColor greenColor];
    view.backgroundColor=[UIColor whiteColor];
    view.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(150)
    .topSpaceToView(self.view,0);
    
    UIImageView * imageview =[[UIImageView alloc]init];
    [view sd_addSubviews:@[imageview]];
    //imageview.backgroundColor=[UIColor yellowColor];
    imageview.image=[UIImage imageNamed:@"logo"];
    imageview.sd_layout
    .centerXEqualToView(view)
    .topSpaceToView(view,20)
    .widthIs(217/2)
    .heightIs(192/2);
    return view;
    
}
-(void)CreatTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[UIView new];
        _tableView.tableHeaderView=[self tableViewHeadView];
        _tableView.backgroundColor=[UIColor whiteColor];
        _tableView.bounces=NO;
        [self.view addSubview:_tableView];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dexArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text=_dataArray[indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:16];
    cell.textLabel.alpha=.7;
    cell.detailTextLabel.text=_dexArray[indexPath.row];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:16];
    return cell;
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
