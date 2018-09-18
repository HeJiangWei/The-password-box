//
//  HTAcountAddRemarksVC.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/23.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTAcountAddRemarksVC.h"

@interface HTAcountAddRemarksVC ()
@property (nonatomic,weak) UITextView * textView;

@end

@implementation HTAcountAddRemarksVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加备注";
    [self creatUI];
    self.automaticallyAdjustsScrollViewInsets = YES;
}

-(void)creatUI
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn dk_setTitleColorPicker:DKColorPickerWithKey(NavigationBarSettingTintColor) forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    __weak typeof(self) __self = self;
    [rightBtn addClickBlock:^(id obj) {
        if (__self.clickedFinish) {
            __self.clickedFinish(__self.textView.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectZero];
    textView.bounces = YES;
    [self.view addSubview:textView];
    self.textView = textView;
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    if (![HTTools ht_isBlankString:self.defaultText]) {
        textView.text = self.defaultText;
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
