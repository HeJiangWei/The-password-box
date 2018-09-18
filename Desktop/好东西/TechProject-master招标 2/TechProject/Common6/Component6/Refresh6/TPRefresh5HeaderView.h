//
//  TPRefresh5HeaderView.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, TPRefreshHeaderState) {
    TPRefreshHeaderStateNone,
    TPRefreshHeaderStatePulling,
    TPRefreshHeaderStateRefreshing,
};
@interface TPRefresh5HeaderView : UIView

@property (nonatomic, copy) void(^handle)(void);
@property (nonatomic, assign) TPRefreshHeaderState status;
- (void)endRefreshing;
@end
