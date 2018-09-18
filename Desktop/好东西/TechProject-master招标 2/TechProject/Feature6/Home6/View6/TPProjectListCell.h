//
//  TPProjectListCell.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPProjectListModel.h"

typedef void(^TPProjectListFavoriteBlock)(TPProjectListItem *item, BOOL add);

@interface TPProjectListCell : UICollectionViewCell

@property (nonatomic, copy) TPProjectListFavoriteBlock block;

- (void)configWith:(TPProjectListItem *)item;
@end
