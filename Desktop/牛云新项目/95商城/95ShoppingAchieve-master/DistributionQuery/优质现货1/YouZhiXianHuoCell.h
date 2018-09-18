//
//  YouZhiXianHuoCell.h
//  DistributionQuery
//
//  Created by Macx on 16/11/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "XiangQingModel.h"
@interface YouZhiXianHuoCell : UITableViewCell
@property(nonatomic,strong)UIButton * chaKanBtn;//立即查看
@property(nonatomic,strong)UIImageView * imagedan;//标题图标
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,retain)HomeModel * model;
@property(nonatomic,retain)XiangQingModel * md;
@end
