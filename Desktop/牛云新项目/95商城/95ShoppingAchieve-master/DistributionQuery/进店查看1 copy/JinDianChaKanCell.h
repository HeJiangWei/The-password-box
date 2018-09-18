//
//  JinDianChaKanCell.h
//  DistributionQuery
//
//  Created by Macx on 16/11/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JinDianModel.h"
@interface JinDianChaKanCell : UITableViewCell
@property(nonatomic,strong)UIButton * chaKanBtn;//立即查看
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)JinDianModel * model;
@end
