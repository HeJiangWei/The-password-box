//
//  TPClientDetailModel.h
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/22.
//  Copyright © 2018年 weiwei. All rights reserved.
//

#import "TPBaseModel.h"
#import "TPClient1Model.h"
@interface TPClientInfoNameItem: NSObject
@property (nonatomic, strong) TPClient1Model *model;
@property (nonatomic, copy)NSString *title;

@end

@interface TPClientInfoItem: NSObject
@property (nonatomic, strong) TPClient1Model *model;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)NSAttributedString *info;
@property (nonatomic, assign) CGFloat height;

- (void)setInfoString:(NSString *)info;
@end
@interface TPClientDetailModel : TPBaseModel

@end
