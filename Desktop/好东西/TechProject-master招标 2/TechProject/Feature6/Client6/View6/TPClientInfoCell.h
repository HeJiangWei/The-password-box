//
//  TPClientInfoCell.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPClientInfoItem;

typedef void(^TPClientInfoEditBlock)(TPClientInfoItem *item);
@interface TPClientInfoCell : UITableViewCell

@property (nonatomic, copy) TPClientInfoEditBlock block;

- (void)configWith:(TPClientInfoItem *)item;

@end
