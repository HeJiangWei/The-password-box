//
//  UIScrollView+TPRefresh.m
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import "UIScrollView+TPRefresh.h"
#import <objc/runtime.h>
static const char kRefreshHeaderKey;

@implementation UIScrollView (TPRefresh)

- (void)addRefreshHeaderWithHandle:(void (^)(void))handle{
    [self addSubview:self.refreshHeader];
    [self insertSubview:self.refreshHeader atIndex:0];
    self.refreshHeader.handle = handle;
}

- (TPRefresh5HeaderView *)refreshHeader {
    TPRefresh5HeaderView *refreshHeader = objc_getAssociatedObject(self, &kRefreshHeaderKey);
    if (!refreshHeader) {
        refreshHeader = [[TPRefresh5HeaderView alloc]initWithFrame:CGRectMake(0, -kDefaultRefreshHeight, [UIScreen mainScreen].bounds.size.width, kDefaultRefreshHeight)];
        objc_setAssociatedObject(self, &kRefreshHeaderKey, refreshHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return refreshHeader;
}

@end
