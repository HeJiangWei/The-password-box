//
//  UIScrollView+TPRefresh.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPRefresh5HeaderView.h"

#define kDefaultRefreshHeight 45.f

@interface UIScrollView (TPRefresh)
@property (nonatomic, readonly) TPRefresh5HeaderView *refreshHeader;

- (void)addRefreshHeaderWithHandle:(void (^)(void))handle;
@end
