//
//  TPNoticeListCell.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPNoticeListItem.h"
#import "TPTopLeft6Label.h"
@interface TPNoticeListCell : UITableViewCell
- (void)configWith:(TPNoticeListItem *)item;
@end
