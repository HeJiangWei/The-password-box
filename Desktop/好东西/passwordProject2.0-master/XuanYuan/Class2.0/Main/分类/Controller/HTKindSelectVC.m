//
//  HTKindSelectVC.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/20.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTKindSelectVC.h"
#import "HTKindAddVC.h"
#import "HTAcountListVC.h"

@interface HTKindSelectVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic,weak) UITableView * tableView;

@end

@implementation HTKindSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigationBar];
    [self creatUI];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.tableView) {
        [self.tableView reloadData];
    }
}



-(void)configNavigationBar
{

    self.title = @"分类";
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(NavigationBarTintColor);
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn dk_setImage:^UIImage *(DKThemeVersion *themeVersion) {
        if ([themeVersion isEqualToString:DKThemeVersionNormal])
        {
            return [UIImage imageNamed:@"icon_add_nor"];
        }else
        {
            return [UIImage imageNamed:@"icon_add_nor"];
        }
    } forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    __weak typeof(self) __self = self;
    [rightBtn addClickBlock:^(id obj) {
        HTKindAddVC *vc = [[HTKindAddVC alloc]init];
        [vc setHidesBottomBarWhenPushed:YES];
        [__self.navigationController pushViewController:vc animated:YES];
    }];
    
}

-(void)creatUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewBackgroundColor);
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.bottom.right.equalTo(self.view);
    }];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"zanwei_Icon"];
}


#pragma -mark- tableView delegate  datasuoce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    RLMResults<HTMainAccountsKindModel *> *modelList = [HTMainAccountsKindModel allObjects];
    return modelList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(textColor_0);
        cell.detailTextLabel.dk_textColorPicker = DKColorPickerWithKey(textColor_1);
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        [cell ht_bottomLineShow];
    }
    RLMResults<HTMainAccountsKindModel *> *modelList = [HTMainAccountsKindModel allObjects];
    HTMainAccountsKindModel *model = [modelList objectAtIndex:indexPath.row];
    RLMResults<HTMainAccountsModel *> *all = [HTMainAccountsModel objectsWhere:[NSString stringWithFormat:@"k_id = '%@'",model.k_id]];
    cell.textLabel.text = model.kindName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%zd",all.count];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RLMResults<HTMainAccountsKindModel *> *modelList = [HTMainAccountsKindModel allObjects];
    HTMainAccountsKindModel *model = [modelList objectAtIndex:indexPath.row];
    HTAcountListVC *vc = [[HTAcountListVC alloc]init];
    vc.k_id = model.k_id;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 返回你所需要的状态栏样式
    return UIStatusBarStyleLightContent;
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
