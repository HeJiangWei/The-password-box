//
//  TPProjectListModel.h
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/10.
//  Copyright © 2018年 cheng. All rights reserved.
//

#import "TPBase4Model.h"

@interface TPProjectListItem: NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *pId;
@property (nonatomic, assign) BOOL isFavorite;
@end

@interface TPProjectListModel : TPBase4Model
@property (nonatomic, assign)BOOL showFavorite;
@end
