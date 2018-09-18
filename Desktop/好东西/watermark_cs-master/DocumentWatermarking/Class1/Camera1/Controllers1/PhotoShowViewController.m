//
//  PhotoShowViewController.m
//  DocumentWatermarking 909090909
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "PhotoShowViewController.h"
#import "PreViewController.h"
#import <Photos/Photos.h>
#import "ShowIMGCollection1Cell.h"
#import <Masonry.h>
#import <UIView+Toast.h>
@interface PhotoShowViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *selectedArray;

@property (nonatomic,assign)CGFloat collectionCellWidth;
@property (nonatomic,strong)UIView *toolBarBGView;//底部栏
@property (nonatomic,strong)UIButton *toolBarLeftBtn;//预览
@property (nonatomic,strong)UIButton *toolBarRightBtn;//完成

@end

@implementation PhotoShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"相册选择";
    self.collectionCellWidth  = kScreenWidth/4;
    
    [self createBar];
    [self createCollectionView];
    [self loadData];
    
    WeakSelf;
    self.backCall = ^{
        if (weakSelf.isNomalPush) {
            [weakSelf.navigationController popViewControllerAnimated:NO];
        }
        else{
            [weakSelf.navigationController popToViewController:weakSelf.navigationController.viewControllers[weakSelf.navigationController.viewControllers.count-3] animated:YES];
        }
    };
    
}

- (void)createBar{
    
    _toolBarBGView = [[UIView alloc]initWithFrame:CGRectZero];
    _toolBarBGView.backgroundColor = [UIColor colorWithRed:0.97 green:0.98 blue:1 alpha:1];
    [self.view addSubview:_toolBarBGView];
    
    [_toolBarBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        make.height.mas_offset(50);
        make.bottom.mas_equalTo(IOS11_OR_LATER?self.view.mas_safeAreaLayoutGuideBottom:self.view.mas_bottom).mas_offset(0);

    }];     

    self.toolBarLeftBtn = [self createBtnWithTitle:@"预览" andBackIMG:nil andTitleColor:[UIColor whiteColor] andSelectedTitleColor:[UIColor whiteColor] andTarget:@selector(toolBarLeftBtnClick) andFram:CGRectMake(10, 7, 60, 30)];
    [_toolBarBGView addSubview:self.toolBarLeftBtn];
    [self.toolBarLeftBtn setTitle:@"预览" forState:UIControlStateSelected];
    [self.toolBarLeftBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateSelected];
    self.toolBarLeftBtn.titleLabel.font = [UIFont systemFontOfSize:13];

    self.toolBarRightBtn = [self createBtnWithTitle:@"确定" andBackIMG:nil andTitleColor:[UIColor whiteColor] andSelectedTitleColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1] andTarget:@selector(toolBarightBtnClick) andFram:CGRectMake(kScreenWidth - 70, 7, 60, 30)];
    [self.toolBarRightBtn setTitle:@"确定" forState:UIControlStateSelected];
    [self.toolBarRightBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    self.toolBarRightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_toolBarBGView addSubview:self.toolBarRightBtn];
    
}

- (void)toolBarightBtnClick{
    if (self.selectedArray.count) {
        if (_isSelectTwo&&_selectedArray.count!=2) {
            [self.view makeToast:@"请选择两张"];
            return;
        }
        [self.navigationController popViewControllerAnimated:NO];
        
        if (_selectBlock) {
            NSMutableArray *arr = [NSMutableArray array];
            for (ShowIMGModel *model in self.selectedArray) {
                PHImageManager *imageManager = [PHImageManager defaultManager];
                [imageManager requestImageForAsset:model.phAsset
                                        targetSize:CGSizeMake(model.phAsset.pixelWidth, model.phAsset.pixelHeight)
                                       contentMode:PHImageContentModeDefault
                                           options:nil
                                     resultHandler:^(UIImage *result, NSDictionary *info) {
                                         NSLog(@"先拿到图片%@",info);
                                         model.tempIMG = result;
                                         if ([[info allKeys] containsObject:@"PHImageFileURLKey"]) {
                                             [arr addObject:result];
                                             if (arr.count==self.selectedArray.count) {
                                                 NSLog(@"先跳转");
                                                 _selectBlock(arr);
                                             }
                                         }
                                     }];
            }
        }
    }
}

- (void)toolBarLeftBtnClick{
    if (!self.selectedArray.count) {
        return;
    }
    NSLog(@"预览");
    PreViewController *pre = [[PreViewController alloc]init];
    pre.imgModelArray = self.selectedArray;
    pre.pageNum       = 0;
    pre.selectedArray = [NSMutableArray arrayWithArray:self.selectedArray];

    WeakSelf;
    pre.selectBlock = ^(NSMutableArray *array,ShowIMGModel *model,BOOL selected){

        weakSelf.selectedArray = [NSMutableArray arrayWithArray:array];
        model.selected = selected;

        if (weakSelf.selectedArray.count) {
            weakSelf.toolBarRightBtn.selected = NO;
           weakSelf.toolBarLeftBtn.selected  = YES;
            [weakSelf.toolBarRightBtn setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)self.selectedArray.count] forState:UIControlStateNormal];
//            weakSelf.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:225/255.0 green:33/255.0 blue:64/255.0 alpha:1];
        }else{
            weakSelf.toolBarRightBtn.selected = YES;
            weakSelf.toolBarLeftBtn.selected  = NO;
//            weakSelf.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:0.91 green:0.93 blue:0.94 alpha:1];

        }
        [weakSelf.collectionView reloadData];

    };
    [self.navigationController pushViewController:pre animated:YES];
    
}


- (UIButton*)createBtnWithTitle:(NSString*)title andBackIMG:(NSString*)name andTitleColor:(UIColor*)color andSelectedTitleColor:(UIColor*)selectTitleColor andTarget:(SEL)clickAction andFram:(CGRect)rect{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn addTarget:self action:clickAction forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:selectTitleColor forState:UIControlStateSelected];
    
    return btn;
    
}



/*
 *  加载图片
 */
- (void)loadData{
    self.dataArray = [NSMutableArray array];
    self.selectedArray = [NSMutableArray array];
    // 列出所有相册智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    
    [smartAlbums enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        PHAssetCollection *assetCollection = obj;
        NSString *tempStr = assetCollection.localizedTitle;
        
        /**
         All Photos:        所有照片
         Bursts:            连拍快照
         Favorites:         收藏
         Selfies:           自拍
         Screenshots:       屏幕快照
         Recently Added:    最近添加
         */
//        if ([tempStr isEqualToString:@"相机胶卷"]) {
        
            PHFetchOptions *options = [[PHFetchOptions alloc] init];
            options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
            
            PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
            self.dataArray = [ShowIMGModel modelWithPHFetchResult:assetsFetchResult WithSelectArray:nil];

//        }
        
    }];

    
    
//    self.selectedArray = [NSMutableArray arrayWithCapacity:0];
//    self.dataArray = [ShowIMGModel modelWithPHFetchResult:self.assetsFetchResult WithSelectArray:self.selectedModel];
//
//    for (ShowIMGModel *model in self.dataArray) {
//        if ([self.selectedModel containsObject:model.phAsset]) {
//            model.selected = YES;
//            [self.selectedArray addObject:model];
//
//            if (self.selectedArray.count) {
//                self.toolBarRightBtn.selected = NO;
//                self.toolBarLeftBtn.selected  = NO;
//                [self.toolBarRightBtn setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)self.selectedArray.count] forState:UIControlStateNormal];
//                self.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:225/255.0 green:33/255.0 blue:64/255.0 alpha:1];
//            }else{
//                self.toolBarRightBtn.selected = YES;
//                self.toolBarLeftBtn.selected  = YES;
//                self.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:0.91 green:0.93 blue:0.94 alpha:1];
//
//            }
//
//        }
//    }
    
    [self.collectionView reloadData];
    
    //    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing      = 0;
    flowLayout.itemSize                = CGSizeMake(kScreenWidth, kScreenHeight);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    [self.collectionView registerClass:[ShowIMGCollection1Cell class] forCellWithReuseIdentifier:@"showView"];
    [self.view addSubview:self.collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.mas_equalTo(self.view).mas_offset(0);
        make.bottom.mas_equalTo(_toolBarBGView.mas_top).mas_offset(0);
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize collectionSize = {self.collectionCellWidth,self.collectionCellWidth};
    return collectionSize;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShowIMGCollection1Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"showView" forIndexPath:indexPath];
    
    ShowIMGModel *model =self.dataArray[indexPath.row];
    
    WeakSelf;
    cell.selectedBlock = ^(BOOL select,UIButton*btn){
        model.selected = select;
        if (select) {
            if (weakSelf.isSelectTwo) {
                if (weakSelf.selectedArray.count==2) {
                    [self.view makeToast:@"最多选择两张"];
                    return ;
                }
            }
            else{
                if (weakSelf.selectedArray.count==1) {
                    [self.view makeToast:@"最多选择一张"];
                    return ;
                }
            }
            btn.selected = YES;
            [weakSelf.selectedArray addObject:model];
        }else{
            btn.selected = NO;
            [weakSelf.selectedArray removeObject:model];
        }
        
        if (weakSelf.selectedArray.count) {
            weakSelf.toolBarRightBtn.selected = NO;
            weakSelf.toolBarLeftBtn.selected  = YES;
            [weakSelf.toolBarRightBtn setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)self.selectedArray.count] forState:UIControlStateNormal];
//            weakSelf.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:225/255.0 green:33/255.0 blue:64/255.0 alpha:1];
        }else{
            weakSelf.toolBarRightBtn.selected = YES;
            weakSelf.toolBarLeftBtn.selected  = NO;
//            self.toolBarRightBtn.backgroundColor = [UIColor colorWithRed:0.91 green:0.93 blue:0.94 alpha:1];
            
        }
    };
    
//    cell.previewBlock = ^(){
//        PreViewController *pre = [[PreViewController alloc]init];
//        pre.imgModelArray = [NSMutableArray arrayWithArray:self.dataArray];
//        pre.pageNum       = indexPath.row;
//        pre.selectedArray = [NSMutableArray arrayWithArray:self.selectedArray];
//        pre.selectBlock = ^(NSMutableArray *array,ShowIMGModel *model,BOOL selected){
//            weakSelf.selectedArray = [NSMutableArray arrayWithArray:array];
//
//            model.selected = selected;
//
//            if (weakSelf.selectedArray.count) {
//                weakSelf.toolBarRightBtn.selected = NO;
//                weakSelf.toolBarLeftBtn.selected  = YES;
//                [weakSelf.toolBarRightBtn setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)self.selectedArray.count] forState:UIControlStateNormal];
//            }else{
//                weakSelf.toolBarRightBtn.selected = YES;
//                weakSelf.toolBarLeftBtn.selected  = NO;
//
//            }
//            [weakSelf.collectionView reloadData];
//
//        };
//        [weakSelf.navigationController pushViewController:pre animated:YES];
//    };
    
    [cell configWithModel:model];
    
    return cell;
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
