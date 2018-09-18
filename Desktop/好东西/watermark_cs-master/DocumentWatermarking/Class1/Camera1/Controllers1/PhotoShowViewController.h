//
//  PhotoShowViewController.h
//  DocumentWatermarking 909090909
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "Base1ViewController.h"
#import <UIKit/UIKit.h>
#import "ShowIMGModel.h"

@interface PhotoShowViewController : Base1ViewController
@property(nonatomic,copy)void(^selectBlock)(NSMutableArray*imageArr);
@property(nonatomic,assign)BOOL isSelectTwo;//默认单张

/**
 是否是正常push,这个字段主要是用到返回按钮的作用上去,不是正常push的返回两个页面,是正常push的直接返回
 默认为不是,比如选取单面双面的时候,要跳转到选取相片,这时候要直接跳转到选取相册,返回的时候要直接返回到单双面选择
 是的话,直接返回,比如直接在页面上选取相册,点击返回就回到页面
 */
@property(nonatomic,assign)BOOL isNomalPush;//正常push,从相册导入,还是在界面上直接选取,默认相册导入no

@end
