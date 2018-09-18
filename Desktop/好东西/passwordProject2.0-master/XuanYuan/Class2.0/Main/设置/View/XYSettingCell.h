//
//  XYSettingCell.h
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/30.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYSettingCell : UITableViewCell

-(void)configTitle:(NSString *)title;
-(void)configSwitch:(BOOL)isOn;
@property (nonatomic, copy) void(^switchChange)(BOOL isOn);

@end
