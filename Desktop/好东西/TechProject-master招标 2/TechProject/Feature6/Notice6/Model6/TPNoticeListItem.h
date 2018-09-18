//
//  TPNoticeListItem.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPNoticeListItem : NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSNumber *aId;
@property (nonatomic, strong) NSNumber *categoryId;

+ (NSArray *)wrapperData:(NSArray *)arr;
@end
