//
//  PreViewController.h
//  DocumentWatermarking 909090909
//
//  Created by apple on 2018/6/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "Base1ViewController.h"
#import <UIKit/UIKit.h>
#import "ShowIMGModel.h"

typedef void(^SelectBlock)(NSMutableArray*array,ShowIMGModel *model,BOOL selected);

typedef void(^ReturnArrayBlock)(NSArray *array);

@interface PreViewController : UIViewController

@property (nonatomic,strong)NSMutableArray *imgModelArray;

@property (nonatomic,strong)NSMutableArray *selectedArray;

@property (nonatomic,assign)NSInteger pageNum;

@property (nonatomic,copy)SelectBlock selectBlock;

@property (nonatomic,copy)ReturnArrayBlock returnArrayBlock;

@end
