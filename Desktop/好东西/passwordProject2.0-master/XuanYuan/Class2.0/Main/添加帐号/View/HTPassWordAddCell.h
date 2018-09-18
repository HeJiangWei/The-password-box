//
//  HTPassWordAddCell.h
//  XuanYuan
//
//  Created by niesiyang on 2018/1/22.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTPassWordAddCell : UITableViewCell
@property (nonatomic, copy) void(^textChange)(NSString *text);
-(void)configText:(NSString *)text;
@end
