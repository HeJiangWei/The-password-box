//
//  TPClientList6Cell.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPClientModel.h"
typedef void(^TPClientListFavoriteBlock)(TPClientModel *model, BOOL add);
@interface TPClientList6Cell : UICollectionViewCell
- (void)configWith:(TPClientModel *)model;
@property (nonatomic, copy) TPClientListFavoriteBlock block;
@end
