//
//  ScanCodeCell.h
//  DistributionQuery
//
//  Created by Macx on 16/11/15.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanCodeCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UIButton * yuYinBtn;
@property(nonatomic,strong)UITextField * textfield;
@end
