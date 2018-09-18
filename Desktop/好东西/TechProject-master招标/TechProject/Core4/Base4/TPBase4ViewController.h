//
//  TPBase4ViewController.h
//  TechProject
//
//  Created by zhengjiacheng on 2018/1/8.
//  Copyright © 2018年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPCommonView4Helper.h"
#import "TPCommonDefine.h"
#import <YYCategories.h>
#import "UIScrollView+TPRefresh.h"
@interface TPBase4ViewController : UIViewController
- (void)showLoading;

- (void)hideLoading;

- (void)showNoDataView;

- (void)hideNoDataView;
@end
