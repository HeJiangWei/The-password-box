//
//  TPClientListCell.h
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/22.
//  Copyright © 2018年 weiwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPClient1Model.h"
typedef void(^TPClientListFavoriteBlock)(TPClient1Model *model, BOOL add);
@interface TPClientListCell : UICollectionViewCell
- (void)configWith:(TPClient1Model *)model;
@property (nonatomic, copy) TPClientListFavoriteBlock block;
@end
