//
//  TPProjectDetailModel.h
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/15.
//  Copyright © 2018年 weiwei. All rights reserved.
//

#import "TPBaseModel.h"
#import "TPProject1Model.h"
@interface TPProjectInfoItem: NSObject
@property (nonatomic, strong) TPProject1Model *model;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)NSAttributedString *info;
@property (nonatomic, assign) CGFloat height;

- (void)setInfoString:(NSString *)info;
@end

@interface TPProjectInfoNameItem: NSObject
@property (nonatomic, strong) TPProject1Model *model;
@property (nonatomic, copy)NSString *title;
@end

@interface TPProjectDetailModel : TPBaseModel

@end
