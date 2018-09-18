//
//  HTInfoPassWordAddCell.h
//  XuanYuan
//
//  Created by niesiyang on 2018/1/22.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTInfoPassWordAddCell : UITableViewCell
@property (nonatomic, copy) void(^textChange)(NSString *subTitle,NSString *password);
-(void)configSubTitle:(NSString *)subTitle andPassword:(NSString *)password;
@end
