//
//  TPProjectDetailModel.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import "TPBase6Model.h"
#import "TPProjectModel.h"
@interface TPProjectInfoItem: NSObject
@property (nonatomic, strong) TPProjectModel *model;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)NSAttributedString *info;
@property (nonatomic, assign) CGFloat height;

- (void)setInfoString:(NSString *)info;
@end

@interface TPProjectInfoNameItem: NSObject
@property (nonatomic, strong) TPProjectModel *model;
@property (nonatomic, copy)NSString *title;
@end

@interface TPProjectDetailModel : TPBase6Model

@end
