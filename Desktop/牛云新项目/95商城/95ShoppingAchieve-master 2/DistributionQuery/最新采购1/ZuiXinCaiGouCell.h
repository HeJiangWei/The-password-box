//
//  ZuiXinCaiGouCell.h
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface ZuiXinCaiGouCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;

@property(nonatomic,strong)HomeModel * model;

@end
