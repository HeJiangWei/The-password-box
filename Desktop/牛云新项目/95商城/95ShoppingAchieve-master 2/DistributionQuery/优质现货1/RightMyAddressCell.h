//
//  RightMyAddressCell.h
//  DistributionQuery
//
//  Created by Macx on 16/11/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightMyAddressCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView*)tableView;
@property(nonatomic,copy)NSString * name;
@end
