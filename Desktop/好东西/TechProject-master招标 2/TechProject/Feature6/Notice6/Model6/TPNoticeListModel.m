//
//  TPNoticeListModel.m
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import "TPNoticeListModel.h"
#import "TPNoticeService.h"
#import "TPNoticeListItem.h"
@interface TPNoticeListModel ()
@property (nonatomic, strong)TPNoticeService *service;
@end

@implementation TPNoticeListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [TPNoticeService new];
    }
    return self;
}

- (void)loadItems:(NSDictionary *)dict completion:(void (^)(NSDictionary *))completion failure:(void (^)(NSError *))failure{
    __weak typeof(self) instance = self;
    [self.service fetchNoticeList:dict success:^(NSDictionary *dict) {
        instance.items = [TPNoticeListItem wrapperData:(NSArray *)dict];
        completion(nil);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
