//
//  TPNoticeListItem.m
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import "TPNoticeListItem.h"

@implementation TPNoticeListItem
+ (NSArray *)wrapperData:(NSArray *)arr{
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        TPNoticeListItem *item = [TPNoticeListItem new];
        item.date = dict[@"date"];
        item.title = dict[@"title"];
        item.url = dict[@"url"];
        item.aId = dict[@"id"];
        item.categoryId = dict[@"category_id"];
        [mutableArr addObject:item];
    }
    return mutableArr;
}
@end
