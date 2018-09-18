//
//  HTAcountDetailVC.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/24.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTAcountDetailVC.h"
#import "HTAcountDetailHeaderCell.h"
#import "HTAcountAddVC.h"
#import "HTAcountDetailCell.h"
#import "HTAcountDetailSubPasswordCell.h"
#import "HTAcountRemarksCell.h"

@interface HTAcountDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView * tableView;
@end

@implementation HTAcountDetailVC

-(HTMainAccountsModel *)getModel
{
    NSString *pred = [NSString stringWithFormat:@"a_id = '%@'",self.a_id];
    RLMResults<HTMainAccountsModel *> *modelList = [HTMainAccountsModel objectsWhere:pred];
    return modelList.firstObject;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_tableView) {
        [self.tableView reloadData];
    }
}

-(void)creatUI
{
    self.title = @"详情";
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn dk_setTitleColorPicker:DKColorPickerWithKey(NavigationBarSettingTintColor) forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    __weak typeof(self) __self = self;
    [rightBtn addClickBlock:^(id obj) {
        HTMainAccountsModel *model = [__self getModel];
        HTAcountAddVC *vc = [[HTAcountAddVC alloc]initWithId:model.a_id];
        XYNavigationController *nav = (XYNavigationController *)__self.navigationController;
        [nav pushViewController:vc animated:YES];
    }];
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = YES;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewBackgroundColor);
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    [tableView registerNib:[UINib nibWithNibName:@"HTAcountDetailHeaderCell" bundle:nil] forCellReuseIdentifier:@"HTAcountDetailHeaderCell"];
    [tableView registerNib:[UINib nibWithNibName:@"HTAcountDetailCell" bundle:nil] forCellReuseIdentifier:@"HTAcountDetailCell"];
    [tableView registerNib:[UINib nibWithNibName:@"HTAcountDetailSubPasswordCell" bundle:nil] forCellReuseIdentifier:@"HTAcountDetailSubPasswordCell"];
    [tableView registerNib:[UINib nibWithNibName:@"HTAcountRemarksCell" bundle:nil] forCellReuseIdentifier:@"HTAcountRemarksCell"];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.bottom.right.equalTo(self.view);
    }];
}

#pragma -mark- tableView delegate  datasuoce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HTMainAccountsModel *model = [self getModel];
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 2;
    }
    if (section == 2) {
        return model.infoPassWord.count;
    }
    if (section == 3) {
        return 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTMainAccountsModel *model = [self getModel];
    if (indexPath.section == 0) {
        NSString *pred = [NSString stringWithFormat:@"k_id = '%@'",model.k_id];
        RLMResults<HTMainAccountsKindModel *> *kindModel = [HTMainAccountsKindModel objectsWhere:pred];
        HTAcountDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAcountDetailHeaderCell"];
        cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%@",@(model.iconType)]];
        cell.acountTitleLabel.text = model.accountTitle;
        cell.acountKindLabel.text = kindModel.firstObject.kindName;
        return cell;
    }
    
    if (indexPath.section == 1) {
        HTAcountDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAcountDetailCell"];
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"用户名称";
            cell.detailTitleLabel.text = model.account;
        }
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"密码";
            cell.detailTitleLabel.text = model.password;
        }
        return cell;
    }
    
    if (indexPath.section == 2) {
        HTMainAccountsSubModel *info = model.infoPassWord[indexPath.row];
        HTAcountDetailSubPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAcountDetailSubPasswordCell"];
        cell.topLabel.text = info.subTitle;
        cell.bottomLabel.text = info.password;
        return cell;
    }
    
    
    if (indexPath.section == 3) {
        HTAcountRemarksCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAcountRemarksCell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell configText:model.remarks];
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTMainAccountsModel *model = [self getModel];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 80;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            CGFloat textHeight = [model.account ht_heightOfFont:[UIFont systemFontOfSize:14] limitWidth:(IPHONE_WIDTH-90)];
            if (textHeight<=44) {
                textHeight = 44;
            }
            return textHeight;
        }
        if (indexPath.row == 1) {
            CGFloat textHeight = [model.password ht_heightOfFont:[UIFont systemFontOfSize:14] limitWidth:(IPHONE_WIDTH-90)];
            if (textHeight<=44) {
                textHeight = 44;
            }
            return textHeight;
        }
    }
    if (indexPath.section == 2) {
        return 55;
    }
    if (indexPath.section == 3) {
        CGFloat textHeight = [model.remarks ht_heightOfFont:[UIFont systemFontOfSize:14] limitWidth:(IPHONE_WIDTH-24)];
        if (textHeight<=21) {
            textHeight = 21;
        }
        return 37+textHeight;
    }
    
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewEmptyColor);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    if (section == 1) {
        return 10;
    }
    if (section == 2) {
        return 10;
    }
    if (section == 3) {
        return 10;
    }
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewEmptyColor);
    return view;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    UIMenuController * menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO animated:YES];
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
