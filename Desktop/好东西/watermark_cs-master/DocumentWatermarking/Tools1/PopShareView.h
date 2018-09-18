//
//  PopShareView.h
//  DocumentWatermarking 909090909
//
//  Created by apple on JW 2018/11/9./15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BasePopView.h"

@interface PopShareView : BasePopView

@property(nonatomic,copy)void(^BtnClickAction)(NSInteger index,NSString *title,BOOL isInstall);

@end
