//
//  TPProjectDataManager.h
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/10.
//  Copyright © 2018年 weiwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPProject1Model.h"
#import "TPProjectRegionModel.h"
#import "TPClient1Model.h"

extern NSString *const TPClientDataDidChangeNotification;
extern NSString *const TPFavoriteStatusDidChangeNotification;

@interface TPProjectDataManager : NSObject

@property (nonatomic, copy, readonly)NSArray <TPProjectRegionModel *> *regionArr;
@property (nonatomic, copy, readonly)NSArray <TPProject1Model *> *projectArr;
@property (nonatomic, copy, readonly)NSArray <TPClient1Model *> *clientArr;

@property (nonatomic, copy, readonly)NSArray *favoriteClientsId;
@property (nonatomic, copy, readonly)NSArray *favoriteProjectId;

+ (instancetype)shareInstance;

- (void)loadData;

- (void)addProjectFromExcel:(NSString *)path;
- (void)addClientFromExcel:(NSString *)path;

- (void)saveClientData:(TPClient1Model *)model;

- (void)addFavoriteProjectId:(NSString *)pId;
- (void)addFavoriteClientId:(NSString *)cId;

- (void)removeFavoriteProjectId:(NSString *)pId;
- (void)removeFavoriteClientId:(NSString *)cId;

- (void)synchronizationFavorite;
@end
