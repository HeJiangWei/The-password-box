//
//  HTAcountAddVC.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/21.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTAcountAddVC.h"
#import "HTAcountAddHeaderCell.h"
#import "HTAcountAddCell.h"
#import "HTPassWordAddCell.h"
#import "HTInfoPassWordAddCell.h"
#import "HTAcountRemarksCell.h"
#import "HTAcountAddRemarksVC.h"

@interface HTAcountAddVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic,strong) HTMainAccountsModel * saveModel;

@property (nonatomic,copy) NSString * a_id;
@property (nonatomic,strong) HTMainAccountsKindItem * item;

@property (nonatomic,assign) BOOL isEdit;


@end

@implementation HTAcountAddVC

- (instancetype)initWithId:(NSString *)a_id
{
    self = [super init];
    if (self) {
        _a_id = a_id;
        _isEdit = YES;
    }
    return self;
}

- (instancetype)initWithKindModel:(HTMainAccountsKindItem *)item
{
    self = [super init];
    if (self) {
        _item = item;
        _isEdit = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self creatUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


-(void)dealloc
{

}

-(void)loadData
{
    if (self.isEdit == NO) {
        self.title = @"新增";
        double creatTime = [[NSDate date]timeIntervalSince1970];
        _saveModel = [[HTMainAccountsModel alloc]initWithValue:@{@"k_push_id":self.item.k_push_id,
                                                                 @"k_id":self.item.k_id,
                                                                 @"a_id":@(creatTime).stringValue,
                                                                 @"creatTime":@(creatTime).stringValue}];
    }
    else
    {
        self.title = @"编辑";
        NSString *pred = [NSString stringWithFormat:@"a_id = '%@'",self.a_id];
        RLMResults<HTMainAccountsModel *> *modelList = [HTMainAccountsModel objectsWhere:pred];
        if (modelList.count<=0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            HTMainAccountsModel *model = modelList.firstObject;
            _saveModel = [[HTMainAccountsModel alloc]init];
            _saveModel.k_push_id = model.k_push_id;
            _saveModel.k_id = model.k_id;
            _saveModel.a_id = model.a_id;
            _saveModel.creatTime = model.creatTime;
            _saveModel.changeTime = model.changeTime;
            _saveModel.accountTitle = model.accountTitle;
            _saveModel.account = model.account;
            _saveModel.password = model.password;
            _saveModel.remarks = model.remarks;
            _saveModel.isCollect = model.isCollect;
            _saveModel.iconType = model.iconType;
            for (HTMainAccountsSubModel *item in model.infoPassWord) {
                
                HTMainAccountsSubModel *i = [[HTMainAccountsSubModel alloc]init];
                i.subTitle = item.subTitle;
                i.password = item.password;
                
                [_saveModel.infoPassWord addObject:i];
            }
        }
    }
}


-(void)creatUI
{
    __weak typeof(self) __self = self;

    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn dk_setTitleColorPicker:DKColorPickerWithKey(NavigationBarSettingTintColor) forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addClickBlock:^(id obj) {
        [__self checkData];
    }];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtn dk_setTitleColorPicker:DKColorPickerWithKey(NavigationBarSettingTintColor) forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [leftBtn addClickBlock:^(id obj) {
        [__self.navigationController popViewControllerAnimated:YES];
    }];
    
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewBackgroundColor);
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.1, 0.1)];
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.1, 0.1)];
    [tableView registerNib:[UINib nibWithNibName:@"HTAcountAddHeaderCell" bundle:nil] forCellReuseIdentifier:@"HTAcountAddHeaderCell"];
    [tableView registerNib:[UINib nibWithNibName:@"HTAcountAddCell" bundle:nil] forCellReuseIdentifier:@"HTAcountAddCell"];
    [tableView registerNib:[UINib nibWithNibName:@"HTPassWordAddCell" bundle:nil] forCellReuseIdentifier:@"HTPassWordAddCell"];
    [tableView registerNib:[UINib nibWithNibName:@"HTInfoPassWordAddCell" bundle:nil] forCellReuseIdentifier:@"HTInfoPassWordAddCell"];
    [tableView registerNib:[UINib nibWithNibName:@"HTAcountRemarksCell" bundle:nil] forCellReuseIdentifier:@"HTAcountRemarksCell"];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.bottom.right.equalTo(self.view);
    }];
}

-(void)checkData
{
    if ([HTTools ht_isBlankString:self.saveModel.accountTitle]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"数据验证失败" message:@"请输入登录信息 名称" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    

    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    if (self.isEdit == NO) {
        RLMResults<HTMainAccountsKindModel *> *all = [HTMainAccountsKindModel objectsWhere:[NSString stringWithFormat:@"k_id = '%@'",self.item.k_id]];
        if (all.count<=0) {
            HTMainAccountsKindModel *model = [[HTMainAccountsKindModel alloc]init];
            model.kindName = self.item.kindName;
            model.kIconType = self.item.kIconType;
            model.k_push_id = self.item.k_push_id;
            model.k_id = self.item.k_id;
            [realm addObject:model];
        }
    }
    [realm addOrUpdateObject:self.saveModel];
    [realm commitWriteTransaction];

    if (self.isEdit == NO)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma -mark- tableView delegate  datasuoce

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) __self = self;
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (indexPath.section == 2) {
            [__self.saveModel.infoPassWord removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
        
    }];
    return @[deleteAction];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isEdit) {
        return 5;
    }
    else
    {
        return 4;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 2;
    }
    if (section == 2) {
        return self.saveModel.infoPassWord.count;
    }
    if (section == 3) {
        return 1;
    }
    if (section == 4) {
        return 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) __self = self;

    if (indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            HTAcountAddHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAcountAddHeaderCell" forIndexPath:indexPath];
            cell.iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%@",@(self.saveModel.iconType)]];
            [cell configText:self.saveModel.accountTitle];
            [cell setTextChange:^(NSString *text) {
                __self.saveModel.accountTitle = text;
            }];
            return cell;
        }
    }
    
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            HTAcountAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAcountAddCell" forIndexPath:indexPath];
            [cell configText:self.saveModel.account];
            [cell setTextChange:^(NSString *text) {
                __self.saveModel.account = text;
            }];
            return cell;
        }
        
        if (indexPath.row == 1) {
            HTPassWordAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTPassWordAddCell"];
            [cell configText:self.saveModel.password];
            [cell setTextChange:^(NSString *text) {
                __self.saveModel.password = text;
            }];
            return cell;
        }
    }
    
    if (indexPath.section == 2) {
        HTMainAccountsSubModel *info = [self.saveModel.infoPassWord objectAtIndex:indexPath.row];
        HTInfoPassWordAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTInfoPassWordAddCell"];
        [cell configSubTitle:info.subTitle andPassword:info.password];
        [cell setTextChange:^(NSString *subTitle, NSString *password) {
            HTMainAccountsSubModel *i = [__self.saveModel.infoPassWord objectAtIndex:indexPath.row];
            i.subTitle = subTitle;
            i.password = password;
        }];
        return cell;
    }
    
    if (indexPath.section == 3) {
        HTAcountRemarksCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTAcountRemarksCell"];
        [cell configText:self.saveModel.remarks];
        return cell;
    }
    if (indexPath.section == 4)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(textRedColor);
        }
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = @"删除";
        return cell;
    }
    
    return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        return 10;
    }
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewEmptyColor);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 80;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 63;
        }
        
        if (indexPath.row == 1) {
            return 101;
        }
    }
    if (indexPath.section == 2) {
        return 68;
    }
    if (indexPath.section == 3) {
        CGFloat textHeight = [self.saveModel.remarks ht_heightOfFont:[UIFont systemFontOfSize:14] limitWidth:(IPHONE_WIDTH-58)];
        if (textHeight<=21) {
            textHeight = 21;
        }
        return 37+textHeight;
    }
    if (indexPath.section == 4) {
        return 44;
    }
    
    return 0;
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
        return 44;
    }
    if (section == 3) {
        return 10;
    }
    if (section == 4) {
        return 10;
    }
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.dk_backgroundColorPicker = DKColorPickerWithKey(viewBackgroundColor);
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitle:@"点击添加次要密码" forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button addTarget:self action:@selector(addinfoPassWord) forControlEvents:UIControlEventTouchUpInside];
        return button;
    }
    
    UIView *view = [[UIView alloc]init];
    view.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewEmptyColor);
    return view;
}

-(void)addinfoPassWord
{
    HTMainAccountsSubModel *sub = [[HTMainAccountsSubModel alloc]init];
    [self.saveModel.infoPassWord addObject:sub];
    [self.tableView reloadData];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak typeof(self) __self = self;
    if (indexPath.section == 3) {
        HTAcountAddRemarksVC *vc = [[HTAcountAddRemarksVC alloc]init];
        vc.defaultText = self.saveModel.remarks;
        [vc setClickedFinish:^(NSString *text) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                __self.saveModel.remarks = text;
                [__self.tableView reloadData];
            });
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 4)
    {
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSString *pred = [NSString stringWithFormat:@"a_id = '%@'",self.a_id];
            RLMResults<HTMainAccountsModel *> *modelList = [HTMainAccountsModel objectsWhere:pred];
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            [realm deleteObject:modelList.firstObject];
            [realm commitWriteTransaction];
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        }];
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil message:@"真的要删除吗?" preferredStyle:UIAlertControllerStyleAlert];
        [vc addAction:action0];
        [vc addAction:action1];
        [self presentViewController:vc animated:YES completion:nil];
    }
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
