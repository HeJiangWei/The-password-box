//
//  TPNoticeCategoryItem.m
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import "TPNoticeCategoryItem.h"

@implementation TPNoticeCategoryItem
+ (NSArray *)wrapperData:(NSArray *)arr{
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        TPNoticeCategoryItem *item = [TPNoticeCategoryItem new];
        item.url = dict[@"url"];
        item.cId = dict[@"id"];
        item.name = dict[@"name"];
        [mutableArr addObject:item];
    }
    return mutableArr;
}
@end
