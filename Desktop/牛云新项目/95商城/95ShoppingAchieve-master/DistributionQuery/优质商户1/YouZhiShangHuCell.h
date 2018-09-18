//
//  YouZhiShangHuCell.h
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface YouZhiShangHuCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)HomeModel * model;
@end
