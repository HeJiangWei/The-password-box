//
//  TPBase6ViewController.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPCommonView6Helper.h"
#import "TPCommon6Define.h"
#import <YYCategories.h>
#import "UIScrollView+TPRefresh.h"
@interface TPBase6ViewController : UIViewController
- (void)showLoading;

- (void)hideLoading;

- (void)showNoDataView;

- (void)hideNoDataView;
@end
