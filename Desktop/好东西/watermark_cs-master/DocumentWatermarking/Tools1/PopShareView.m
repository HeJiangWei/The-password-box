//
//  PopShareView.m
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PopShareView.h"
#import "ShareCell.h"
//#import <WXApi.h>
//#import <WeiboSDK.h>
//#import <TencentOpenAPI/QQApiInterface.h>

@interface PopShareView()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
    UICollectionView *_bottomCollectionView;
    UIView *_lineView;
    UIView *_bottomView;
    UICollectionViewFlowLayout *_layout;
    NSMutableArray *titleArr;//标题数组
    NSMutableArray *imageArr;//图片数组
    NSMutableArray *isInstallArr;//是否安装平台
}

@end

@implementation PopShareView

-(void)initView{
    
//    [super initView];
//    titleArr = [NSMutableArray array];
//    imageArr = [NSMutableArray array];
//    isInstallArr = [NSMutableArray arrayWithObjects:@(0),@(0),@(0),@(0),@(0),nil];
//
//    [titleArr addObject:@"QQ好友"];
//    [titleArr addObject:@"QQ空间"];
//    [imageArr addObject:UMSocialPlatformThemeIconWithName(@"umsocial_qq")];
//    [imageArr addObject:UMSocialPlatformThemeIconWithName(@"umsocial_qzone")];
//    if ([QQApiInterface isQQInstalled]&&[QQApiInterface isQQSupportApi]) {
        //        用户已经安装qq并且支持当前版本的api
        [isInstallArr replaceObjectAtIndex:0 withObject:@(1)];
        [isInstallArr replaceObjectAtIndex:1 withObject:@(1)];

//    }
    [titleArr addObject:@"微信好友"];
    [titleArr addObject:@"朋友圈"];
//    [imageArr addObject:UMSocialPlatformThemeIconWithName(@"umsocial_wechat")];
//    [imageArr addObject:UMSocialPlatformThemeIconWithName(@"umsocial_wechat_timeline")];
//    if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
        //用户安装了微信并且支持当前的版本的api
        [isInstallArr replaceObjectAtIndex:2 withObject:@(1)];
        [isInstallArr replaceObjectAtIndex:3 withObject:@(1)];
//    }
    
//    [titleArr addObject:@"新浪微博"];
//    [imageArr addObject:UMSocialPlatformThemeIconWithName(@"umsocial_sina")];
//    if ([WeiboSDK isWeiboAppInstalled]&&[WeiboSDK isCanShareInWeiboAPP]) {
        //用户已经安装微博并且支持当前版本的api
//        [isInstallArr replaceObjectAtIndex:4 withObject:@(1)];
//    }

//    _layout = [[UICollectionViewFlowLayout alloc]init];
//    _layout.minimumLineSpacing = 5;
//    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    _layout.itemSize = CGSizeMake(80, 100);
//
//    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 110) collectionViewLayout:_layout];
//    _collectionView.backgroundColor = [UIColor whiteColor];
//    _collectionView.delegate =self;
//    _collectionView.dataSource =self;
//    _collectionView.showsHorizontalScrollIndicator = NO;
//    [self.contentView addSubview:_collectionView];
//    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ShareCell class]) bundle:nil] forCellWithReuseIdentifier:@"ShareCell"];

    
//    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 100)];
//    _bottomView.backgroundColor = [UIColor whiteColor];
//    [self.contentView addSubview:_bottomView];
//    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 2, kScreenWidth, 1)];
//    _lineView.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
//    [_bottomView addSubview:_lineView];

//    ShareCell *helper = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ShareCell class]) owner:nil options:0].firstObject;
//    helper.imageView.image = [UIImage imageNamed:@"帮助"];
//    CGRect frame = helper.imageView.frame;
//    frame.size = CGSizeMake(30, 30);
//    helper.imageView.frame = frame;
//    helper.nameLabel.text = @"帮助中心";
//    [_bottomView addSubview:helper];
    
//    ShareCell *advice = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ShareCell class]) owner:nil options:0].firstObject;
//    advice.imageView.image = [UIImage imageNamed:@"建议"];
//    advice.nameLabel.text = @"功能建议";
//    [_bottomView addSubview:advice];

//    UIButton *helperBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    helperBtn.frame = CGRectMake(15, 10, 70 , 70);
//    [helperBtn setTitle:@"帮助中心" forState:UIControlStateNormal];
//    [helperBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [helperBtn setImage:[UIImage imageNamed:@"帮助"] forState:UIControlStateNormal];
//    [helperBtn addTarget:self action:@selector(helperAction) forControlEvents:UIControlEventTouchUpInside];
//    helperBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    helperBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    helperBtn.imageEdgeInsets = UIEdgeInsetsMake(5, helperBtn.imageView.frame.origin.x+11, 30, 0);
//    helperBtn.titleEdgeInsets = UIEdgeInsetsMake(helperBtn.currentImage.size.height+15,-helperBtn.currentImage.size.width,5,0);

//    [_bottomView addSubview:helperBtn];
    
//    UIButton *adviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    adviceBtn.frame = CGRectMake(90, 10, 70 , 70);
//    [adviceBtn setTitle:@"功能建议" forState:UIControlStateNormal];
//    [adviceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [adviceBtn setImage:[UIImage imageNamed:@"建议"] forState:UIControlStateNormal];
//    [adviceBtn addTarget:self action:@selector(adviceBtnAction)
//        forControlEvents:UIControlEventTouchUpInside];
//    adviceBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    adviceBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    adviceBtn.imageEdgeInsets = UIEdgeInsetsMake(5, adviceBtn.imageView.frame.origin.x+11, 30, 0);
//    adviceBtn.titleEdgeInsets = UIEdgeInsetsMake(adviceBtn.currentImage.size.height+15,-adviceBtn.currentImage.size.width,5,0);
//    [_bottomView addSubview:adviceBtn];

//    _bottomCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 101, kScreenWidth, 100) collectionViewLayout:_layout];
//    _bottomCollectionView.backgroundColor = [UIColor whiteColor];
//    _bottomCollectionView.delegate =self;
//    _bottomCollectionView.dataSource =self;
//    _bottomCollectionView.showsHorizontalScrollIndicator = NO;
//    [self.contentView addSubview:_bottomCollectionView];
//
//    [_bottomCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ShareCell class]) bundle:nil] forCellWithReuseIdentifier:@"ShareCell"];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _collectionView) {
        return titleArr.count;
    }
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView==_collectionView) {
        ShareCell *shareCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShareCell" forIndexPath:indexPath];
        
        shareCell.imageView.image = [UIImage imageNamed:imageArr[indexPath.row]];
        shareCell.nameLabel.text = titleArr[indexPath.row];
        
        return shareCell;
    }
    else{
        ShareCell *shareCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShareCell" forIndexPath:indexPath];
        if (indexPath.row==0) {
            shareCell.imageView.image = [UIImage imageNamed:@"帮助"];
            shareCell.nameLabel.text = @"帮助中心";
        }
        else{
            shareCell.imageView.image = [UIImage imageNamed:@"建议"];
            shareCell.nameLabel.text = @"功能建议";
        }
        return shareCell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([@"QQ好友" isEqualToString:titleArr[indexPath.row]]) {
//        //  [MobClick event:@"share_qq_friend"];

        
    }else if ([@"QQ空间" isEqualToString:titleArr[indexPath.row]]){
        
//        //  [MobClick event:@"share_qq_qzone"];

    }else if ([@"微信好友" isEqualToString:titleArr[indexPath.row]]){
//        //  [MobClick event:@"share_wechat_friend"];

        
    }else if ([@"朋友圈" isEqualToString:titleArr[indexPath.row]]){
        
//        //  [MobClick event:@"share_wechat_circle"];

    }else if ([@"新浪微博" isEqualToString:titleArr[indexPath.row]]){
        
//        //  [MobClick event:@"share_weibo"];

    }
    
    [self diss];
    if (_BtnClickAction) {
        _BtnClickAction(indexPath.row,titleArr[indexPath.row],[isInstallArr[indexPath.row] integerValue]);
    }
}
/*
 *  按钮事件
 */
-(void)helperAction{
//    //  [MobClick event:@"share_help"];
    [self diss];
    if (_BtnClickAction) {
        _BtnClickAction(100,@"帮助",YES);
    }

}
/*
 *  按钮事件
 */
-(void)adviceBtnAction{
//    //  [MobClick event:@"share_feedback"];

    [self diss];
    if (_BtnClickAction) {
        _BtnClickAction(200,@"建议",YES);
    }

}
@end
