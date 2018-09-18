//
//  Messagejw0803Cell.h
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2018年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Messagejw0803Cell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UITextField * textfield;
@end
