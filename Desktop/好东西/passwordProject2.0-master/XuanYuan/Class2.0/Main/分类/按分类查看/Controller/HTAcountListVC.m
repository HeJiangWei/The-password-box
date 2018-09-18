//
//  HTAcountListVC.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/23.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTAcountListVC.h"
#import "HTAcountAddVC.h"
#import "HTAcountListCell.h"
#import "HTAcountDetailVC.h"


@interface HTAcountListVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic,weak) UITableView * tableView;

@end

@implementation HTAcountListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_tableView) {
        [_tableView reloadData];
    }
}

-(void)creatUI
{
    RLMResults<HTMainAccountsKindModel *> *all = [HTMainAccountsKindModel objectsWhere:[NSString stringWithFormat:@"k_id = '%@'",self.k_id]];
    HTMainAccountsKindModel *model = all.firstObject;
    self.title = model.kindName;
    
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
        HTMainAccountsKindItem *item = [[HTMainAccountsKindItem alloc]init];
        item.kindName = model.kindName;
        item.k_push_id = model.k_push_id;
        item.kIconType = model.kIconType;
        item.k_id = model.k_id;
        HTAcountAddVC *vc = [[HTAcountAddVC alloc]initWithKindModel:item];
        XYNavigationController *nav = (XYNavigationController *)__self.navigationController;
        [nav pushViewController:vc animated:YES];
    }];
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [tableView registerNib:[UINib nibWithNibName:@"HTAcountListCell" bundle:nil] forCellReuseIdentifier:@"HTAcountListCell"];
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
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"您的账号库还是空的哦~";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0f],
                                 NSForegroundColorAttributeName:RGBHex(0x999999)
                                 };
    NSMutableAttributedString *st = [[NSMutableAttributedString alloc]initWithString:title attributes:attributes];
    return st;
}
#pragma -mark- tableView delegate  datasuoce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    RLMResults<HTMainAccountsModel *> *all = [HTMainAccountsModel objectsWhere:[NSString stringWithFormat:@"k_id = '%@'",self.k_id]];

    return all.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTAcountListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAcountListCell"];
    RLMResults<HTMainAccountsModel *> *all = [HTMainAccountsModel objectsWhere:[NSString stringWithFormat:@"k_id = '%@'",self.k_id]];
    HTMainAccountsModel *model = [all objectAtIndex:indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%@",@(model.iconType)]];
    cell.acountTitleLabel.text = model.accountTitle;
    cell.acountLabel.text = model.account;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RLMResults<HTMainAccountsModel *> *all = [HTMainAccountsModel objectsWhere:[NSString stringWithFormat:@"k_id = '%@'",self.k_id]];
    HTMainAccountsModel *model = [all objectAtIndex:indexPath.row];
    
    HTAcountDetailVC *v = [[HTAcountDetailVC alloc]init];
    v.a_id = model.a_id;
    [self.navigationController pushViewController:v animated:YES];
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
