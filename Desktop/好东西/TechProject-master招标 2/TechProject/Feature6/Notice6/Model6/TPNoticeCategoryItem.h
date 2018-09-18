//
//  TPNoticeCategoryItem.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPNoticeCategoryItem : NSObject
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *cId;

+ (NSArray *)wrapperData:(NSArray *)arr;
@end
