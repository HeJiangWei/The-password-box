//
//  TPNoticeVCL.m
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/8.
//  Copyright © 2018年 cheng. All rights reserved.
//

#import "TPNoticeVCL.h"
#import "TPCommonView4Helper.h"
#import "TPNoticeCategoryItem.h"
#import "TPNoticeModel.h"
#import "TPCommonDefine.h"
#import "TPNoticeListVCL.h"
#import "TPNoticeCategoryCell.h"
#import <MJRefresh.h>
#import <MBProgressHUD.h>
@interface TPNoticeVCL ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) TPNoticeModel *model;
@end

@implementation TPNoticeVCL

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
         self.model = [TPNoticeModel new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNaviBar];
    self.tabBarItem.image = [[UIImage imageNamed:@"tab_notice"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_notice_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    __weak typeof(self) instance = self;
    [self.collectionView addRefreshHeaderWithHandle:^{
        [instance loadData];
    }];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(TPScreenWidth/3, TPScreenWidth/3 - 20);
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.frame = CGRectMake(0, TPStatusBarAndNavigationBarHeight, TPScreenWidth, TPScreenHeight - TPStatusBarAndNavigationBarHeight - TPTabbarSafeBottomMargin - TPTabbarHeight);
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)addNaviBar{
    UIView *naviBar = [TPCommonView4Helper createNavigationBar:@"公告" enableBackButton:NO];
    [self.view addSubview:naviBar];
}

- (void)loadData{
    if (!self.model.items || self.model.items.count < 1) {
//        [self showLoading];
    }
    __weak typeof(self) instance = self;
    
    TPNoticeCategoryItem *item = [[TPNoticeCategoryItem alloc] init];
    item.url = @"http://www.gov.cn/xinwen/2017-11/30/content_5243589.htm";
    item.name =  @"第一严谨作风";
//    item.cId = @"12";
    
    TPNoticeCategoryItem *item1 = [[TPNoticeCategoryItem alloc] init];
    item1.url = @"http://www.gov.cn/xinwen/2017-11/30/content_5243589.htm";
    item1.name =  @"第二认真负责";
    
    TPNoticeCategoryItem *item2 = [[TPNoticeCategoryItem alloc] init];
    item2.url = @"http://www.gov.cn/xinwen/2017-11/30/content_5243589.htm";
    item2.name =  @"第三实事求是";
    
    TPNoticeCategoryItem *item3 = [[TPNoticeCategoryItem alloc] init];
    item3.url = @"http://www.gov.cn/xinwen/2017-11/30/content_5243589.htm";
    item3.name =  @"第四脚踏实地";
    
//    item1.cId = @"12";
    NSArray *array1 = [NSArray arrayWithObjects:item,item1,item2,item3 ,nil];
    self.model.items = array1;
    [instance.collectionView reloadData];

    
//    [self.model loadItems:nil completion:^(NSDictionary *success) {
//        [instance hideLoading];
//        [instance.collectionView.refreshHeader endRefreshing];
//        [instance.collectionView reloadData];
//    } failure:^(NSError *error) {
//        []
//        [MBProgressHUD ]
//        instance s
//        MBProgressHUD *hub = [[MBProgressHUD alloc] init];
//        
//        [hub showAnimated:YES];
//        [instance hideLoading];
//        [instance.collectionView.refreshHeader endRefreshing];
//    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.items.count;;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TPNoticeCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TPNoticeCategoryCell" forIndexPath:indexPath];
    TPNoticeCategoryItem *item = self.model.items[indexPath.row];
    cell.text  = item.name;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    TPNoticeListVCL *listVCL = (TPNoticeListVCL *)[main instantiateViewControllerWithIdentifier:@"TPNoticeListVCL"];
//    TPNoticeCategoryItem *item = self.model.items[indexPath.row];
//    listVCL.categoryId = item.cId;
//    [self.navigationController pushViewController:listVCL animated:YES];
}
@end

