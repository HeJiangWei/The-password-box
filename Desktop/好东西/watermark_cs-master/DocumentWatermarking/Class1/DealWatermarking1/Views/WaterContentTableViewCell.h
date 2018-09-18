//
//  WaterContentTableViewCell.h
//  DocumentWatermarking 909090909
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface WaterContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *waterContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *clickButton;

@property(nonatomic,copy)void(^editAction)();

@end
