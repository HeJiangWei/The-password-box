//
//  HTAcountAddCell.h
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/21.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTAcountAddCell : UITableViewCell
@property (nonatomic, copy) void(^textChange)(NSString *text);
-(void)configText:(NSString *)text;
@end
