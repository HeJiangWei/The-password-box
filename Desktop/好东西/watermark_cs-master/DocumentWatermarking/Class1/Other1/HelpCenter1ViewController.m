//
//  HelpCenter1ViewController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HelpCenter1ViewController.h"
@interface HelpCenter1ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) NSArray * titleArr;
@property(nonatomic,strong)UIWebView*web;

@end

@implementation HelpCenter1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"帮助中心";
    
    _web = [[UIWebView alloc]initWithFrame:CGRectZero];
    
//    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.yiyong.com/sy/"]]];
    [self.view addSubview:_web];
    
    [_web mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.right.left.mas_equalTo(self.view).mas_offset(0);
        make.bottom.mas_equalTo(IOS11_OR_LATER?self.view.mas_safeAreaLayoutGuideBottom:self.view.mas_bottom).mas_offset(0);
        
    }];
    
//    
//    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    tableView.backgroundColor = [UIColor clearColor];
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
////    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
//
//    [self.view addSubview:tableView];
//    
//    self.titleArr = [NSArray arrayWithObjects:@"消除缓存",@"当前版本", nil];
    
}


#pragma -mark tableView的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row==1) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // app版本
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        cell.detailTextLabel.text = app_Version;
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end
