//
//  AllShangPinVC.h
//  DistributionQuery
//
//  Created by Macx on 16/11/16.
//  Copyright © 2018年 Macx. All rights reserved.
//

#import "Basejw0803ViewController.h"

@interface AllShangPinVC : Basejw0803ViewController
/*
 11.所有商品
 12.新品上架
 13.经典旧货
 14.优质好货
 
 */
@property(nonatomic,assign)NSInteger tagg;
//从店铺穿过来的ID，产品ID
@property(nonatomic,copy)NSString * messageID;//
/*
 0全部 1最新 2经典 3优质
 */
@property(nonatomic,assign)NSInteger  cidd;
@end
