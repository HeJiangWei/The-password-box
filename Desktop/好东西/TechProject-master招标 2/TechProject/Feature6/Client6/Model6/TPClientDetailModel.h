//
//  TPClientDetailModel.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import "TPBase6Model.h"
#import "TPClientModel.h"
@interface TPClientInfoNameItem: NSObject
@property (nonatomic, strong) TPClientModel *model;
@property (nonatomic, copy)NSString *title;

@end

@interface TPClientInfoItem: NSObject
@property (nonatomic, strong) TPClientModel *model;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)NSAttributedString *info;
@property (nonatomic, assign) CGFloat height;

- (void)setInfoString:(NSString *)info;
@end
@interface TPClientDetailModel : TPBase6Model

@end
