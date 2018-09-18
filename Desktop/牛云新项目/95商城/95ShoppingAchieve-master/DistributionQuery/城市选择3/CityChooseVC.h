//
//  CityChooseVC.h
//  DistributionQuery
//
//  Created by Macx on 16/11/23.
//  Copyright © 2018年 Macx. All rights reserved.
//

#import "Basejw0803ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface CityChooseVC : Basejw0803ViewController<CLLocationManagerDelegate>
{
    CLLocationManager * _manager;
    //地理编码 反编码
    CLGeocoder * _coder;
}
@property(nonatomic,copy)void(^citynameBlock)(NSString*name,NSString*code,NSString*shengCode);
@end
