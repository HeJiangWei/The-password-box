//
//  HTKindAddVC.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/20.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTKindAddVC.h"
#import "HTToolSet.h"
#import "HTAcountAddVC.h"

@interface HTKindAddVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray<HTMainAccountsKindItem *> * dataArray;
@end

@implementation HTKindAddVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadData];
    }
    return self;
}

-(void)loadData
{
    RLMResults<HTMainAccountsKindModel *> *modelList = [HTMainAccountsKindModel allObjects];
    NSMutableArray *dataArray = [NSMutableArray array];

    if (modelList.count<=0) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"kindList" ofType:@"plist"];
        NSArray *array = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        for (NSDictionary *dict in array) {
            HTMainAccountsKindItem *item = [HTMainAccountsKindItem mj_objectWithKeyValues:dict];
            HTMainAccountsKindModel *model = [[HTMainAccountsKindModel alloc]init];
            model.kindName = item.kindName;
            model.kIconType = item.kIconType;
            model.k_push_id = item.k_push_id;
            model.k_id = item.k_id;
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            [realm addObject:model];
            [realm commitWriteTransaction];
        }
    }

    for (HTMainAccountsKindModel *model in modelList) {
        HTMainAccountsKindItem *item = [[HTMainAccountsKindItem alloc]init];
        item.kindName = model.kindName;
        item.kIconType = model.kIconType;
        item.k_push_id = model.k_push_id;
        item.k_id = model.k_id;
        [dataArray addObject:item];
    }
    _dataArray = dataArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择分类";
    [self creatUI];

}



-(void)creatUI
{
    __weak typeof(self) __self = self;
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
    [rightBtn addClickBlock:^(id obj) {
        [__self addKind];
    }];
    
    
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
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.bottom.right.equalTo(self.view);
    }];
}

-(void)addKind
{
    __weak typeof(self) __self = self;
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil message:@"添加一个新的分类" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textfiele = vc.textFields.firstObject;
        double creatTime = [[NSDate date]timeIntervalSince1970];
        HTMainAccountsKindModel *model = [[HTMainAccountsKindModel alloc]init];
        model.kindName = textfiele.text;
        model.kIconType = 0;
        model.k_push_id = @"acount";
        model.k_id = @(creatTime).stringValue;
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addObject:model];
        [realm commitWriteTransaction];
        [__self loadData];
        [__self.tableView reloadData];
    }];
    action0.enabled = NO;
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [vc addAction:action0];
    [vc addAction:action1];
    [vc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"至少输入两个文字";
        __weak typeof(textField) __textField = textField;
        __weak typeof(action0)   __action0 = action0;
        [textField ht_editingChanged:^{
            if (__textField.text.length>=2) {
                __action0.enabled = YES;
            }
            else
            {
                __action0.enabled = NO;
            }
        }];
    }];
    [self presentViewController:vc animated:YES completion:nil];
    
}

#pragma -mark- tableView delegate  datasuoce

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTMainAccountsKindItem *item = self.dataArray[indexPath.row];

    if (![item.k_id isEqualToString:@"0"]) {
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
        HTMainAccountsKindItem *item = __self.dataArray[indexPath.row];
        RLMResults<HTMainAccountsKindModel * > *modelList = [HTMainAccountsKindModel objectsWhere:[NSString stringWithFormat:@"k_id = '%@'",item.k_id]];
        
        RLMResults<HTMainAccountsModel * > *acountModelList = [HTMainAccountsModel objectsWhere:[NSString stringWithFormat:@"k_id = '%@'",item.k_id]];
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];

        for (HTMainAccountsKindModel *kModel in modelList) {
            [realm deleteObject:kModel];
        }
        
        for (HTMainAccountsModel *aModel in acountModelList) {
            aModel.k_id = @"0";
        }
        [realm commitWriteTransaction];
        [__self loadData];
        [__self.tableView reloadData];
    }];
    return @[deleteAction];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(textColor_0);
        [cell ht_bottomLineShow];
    }
    HTMainAccountsKindItem *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.kindName;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HTMainAccountsKindItem *model = self.dataArray[indexPath.row];
    if ([model.k_push_id isEqualToString:@"acount"])
    {//帐号信息
        HTAcountAddVC *vc = [[HTAcountAddVC alloc]initWithKindModel:model];
        XYNavigationController *nav = (XYNavigationController *)self.navigationController;
        [nav pushViewController:vc animated:YES];
    }
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
