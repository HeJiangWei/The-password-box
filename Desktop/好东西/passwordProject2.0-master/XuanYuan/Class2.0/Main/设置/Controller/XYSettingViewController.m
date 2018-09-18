//
//  XYSettingViewController.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/20.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "XYSettingViewController.h"
#import "XYSettingCell.h"
#import "HTSettingPasswordViewController.h"

@interface XYSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation XYSettingViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _dataArray = [NSMutableArray array];
        
        [_dataArray addObject:@[@"清除缓存"]];
        [_dataArray addObject:@[@"恢复默认设置",@"允许自定义键盘",@"入侵记录"]];
        [_dataArray addObject:@[@"设置启动密码"]];
        [_dataArray addObject:@[@"吐槽微密"]];
        [_dataArray addObject:@[@"Copyright(c)2017"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigationBar];
    [self creatUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void)configNavigationBar
{
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(NavigationBarSettingTintColor);
}

-(void)creatUI
{
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
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    [tableView registerNib:[UINib nibWithNibName:@"XYSettingCell" bundle:nil] forCellReuseIdentifier:@"XYSettingCell"];
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
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataArray[section];
    return array.count;;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.dataArray[indexPath.section][indexPath.row];
    
    if ([title isEqualToString:@"清除缓存"])
    {
        
    }
    if ([title isEqualToString:@"恢复默认设置"])
    {
        
    }
    if ([title isEqualToString:@"允许自定义键盘"])
    {
        BOOL isAllowThirdKeyboard = [[HTConfigManager sharedconfigManager]isAllowThirdKeyboard];
        XYSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XYSettingCell"];
        [cell configTitle:title];
        [cell configSwitch:isAllowThirdKeyboard];
        [cell setSwitchChange:^(BOOL isOn) {
            [[HTConfigManager sharedconfigManager] isAllowThirdKeyboard:isOn];
        }];
        return cell;
    }
    if ([title isEqualToString:@"入侵记录"])
    {
        
    }
    if ([title isEqualToString:@"设置启动密码"])
    {
        
    }
    if ([title isEqualToString:@"吐槽微密"])
    {
        BOOL isSend = [[HTConfigManager sharedconfigManager] canSendEmail];
        if (!isSend) {
           title = [title stringByAppendingString:@"(不可用)"];
        }
    }
    if ([title isEqualToString:@"Copyright(c)2017"])
    {
        
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        [cell ht_bottomLineShow];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    cell.textLabel.text = title;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewEmptyColor);
    return view;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.dataArray[indexPath.section][indexPath.row];
    
    if ([title isEqualToString:@"清除缓存"])
    {
        [self unopenFunction];
    }
    if ([title isEqualToString:@"恢复默认设置"])
    {
        [self defaultSetting];
    }
    if ([title isEqualToString:@"允许自定义键盘"])
    {

    }
    if ([title isEqualToString:@"入侵记录"])
    {
        [self unopenFunction];
    }
    if ([title isEqualToString:@"设置启动密码"])
    {
        if (![[HTConfigManager sharedconfigManager]isOpenStartPassword]) {
            HTSettingPasswordViewController *vc = instantiateStoryboardControllerWithIdentifier(@"HTSettingPasswordViewController");
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [self cancelPassword];
        }
    }
    if ([title isEqualToString:@"吐槽微密"])
    {
        BOOL isSend = [[HTConfigManager sharedconfigManager] canSendEmail];
        if (isSend) {
            [self sendEmail];
        }
    }
    if ([title isEqualToString:@"Copyright(c)2017"])
    {
        
    }
}


-(void)unopenFunction
{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil message:@"暂未开放该功能" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [vc addAction:action0];
    [self presentViewController:vc animated:YES completion:nil];
}

/**
 发送邮件
 */
-(void)sendEmail
{
    NSString *subject = @"微密-反馈邮件";
    NSString *recipients = @"siyang.nie.520@gmail.com";
    NSString *body = [NSString stringWithFormat:@"机器型号:%@\n系统版本:%@\n反馈问题:\n",[HTTools deviceVersion],[HTTools phoneVersion]];
    [[HTConfigManager sharedconfigManager] sendEmailActionWithSubject:subject Recipients:recipients MessageBody:body];
}


//恢复默认设置
-(void)defaultSetting
{
    if ([[HTConfigManager sharedconfigManager]isOpenStartPassword])
    {
        [HTProgressHUD showMessage:@"请先取消启动密码" forView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self cancelPassword];
        });
    }
    else
    {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:nil message:@"恢复默认设置?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[HTConfigManager sharedconfigManager]defaultSetting];
            [self.tableView reloadData];
        }];
        [vc addAction:action0];
        [vc addAction:action1];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

//取消启动密码
-(void)cancelPassword
{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"您已经设置过启动密码" message:@"是否需要清空该密码?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *tf = vc.textFields.firstObject;
        if ([[HTConfigManager sharedconfigManager]checkInputPassword:tf.text])
        {
            [[HTConfigManager sharedconfigManager]isOpenStartPassword:NO];
            [[HTConfigManager sharedconfigManager]startPassword:nil];
            [HTProgressHUD showMessage:@"取消成功" forView:self.view];
        }
        else
        {
            [HTProgressHUD showMessage:@"密码错误" forView:self.view];
        }
    }];
    action1.enabled = NO;
    [vc addAction:action0];
    [vc addAction:action1];
    [vc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.secureTextEntry = YES;
        __weak typeof(textField) __textField = textField;
        __weak typeof(action1) __action1 = action1;
        [textField ht_editingChanged:^{
            if (__textField.markedTextRange == nil) {
                if (__textField.text.length>=3)
                {
                    __action1.enabled = YES;
                }
                else
                {
                    __action1.enabled = NO;
                }
            }
        }];
    }];
    [self presentViewController:vc animated:YES completion:nil];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 返回你所需要的状态栏样式
    return UIStatusBarStyleDefault;
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
