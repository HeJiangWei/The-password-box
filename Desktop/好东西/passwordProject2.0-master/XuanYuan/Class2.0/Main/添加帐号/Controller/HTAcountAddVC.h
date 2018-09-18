//
//  HTAcountAddVC.h
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/21.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "XYBaseViewController.h"

@interface HTAcountAddVC : XYBaseViewController


//新增使用这个方法
-(instancetype)initWithKindModel:(HTMainAccountsKindItem *)item;

//编辑使用这个
-(instancetype)initWithId:(NSString *)a_id;

@end
