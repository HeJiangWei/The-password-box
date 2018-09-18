//
//  TPProjectListModel.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import "TPBase6Model.h"

@interface TPProjectListItem: NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *pId;
@property (nonatomic, assign) BOOL isFavorite;
@end

@interface TPProjectListModel : TPBase6Model
@property (nonatomic, assign)BOOL showFavorite;
@end
