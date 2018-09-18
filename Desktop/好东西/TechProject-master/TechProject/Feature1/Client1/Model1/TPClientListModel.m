//
//  TPClientListModel.m
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/22.
//  Copyright © 2018年 weiwei. All rights reserved.
//

#import "TPClientListModel.h"
#import "TPProjectDataManager.h"
#import "TPClient1Model.h"
@implementation TPClientListModel
- (void)loadItems:(NSDictionary *)dict completion:(void (^)(NSDictionary *))completion failure:(void (^)(NSError *))failure{
    NSArray *arr = [TPProjectDataManager shareInstance].clientArr;
    NSArray *fArr = [TPProjectDataManager shareInstance].favoriteClientsId;
    NSMutableArray *mutableArr = [NSMutableArray array];
    if (self.showFavorite) {
        for (TPClient1Model *model in arr) {
            if (self.showFavorite && [fArr containsObject:model.clientId]) {
                [mutableArr addObject:model];
            }
        }
    }else{
        for (TPClient1Model *model in arr) {
            [mutableArr addObject:model];
        }
    }

    self.items = mutableArr;
    completion(nil);
}
@end
