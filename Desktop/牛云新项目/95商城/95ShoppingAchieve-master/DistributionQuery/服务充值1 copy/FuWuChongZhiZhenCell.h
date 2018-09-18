//
//  FuWuChongZhiZhenCell.h
//  DistributionQuery
//
//  Created by Macx on 16/12/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuWuChongZhiZhenCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)NSDictionary * dic;
@property(nonatomic,strong)UIButton * chongZhiBtn;
@end
