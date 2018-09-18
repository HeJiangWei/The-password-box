//
//  JW0905KDAlertView.h
//  BaseWebFoundation
//
//  Created by xiao6 on JW0905/12/13.
//  Copyright © JW0905年 JW0905. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JW0905KDAlertView : UIAlertController
+ (instancetype)JW0905showTitle:(NSString *)title message:(NSString *)message buttons:(NSArray<NSString *> *)buttons completion:(void(^)(NSUInteger index, NSString *buttonTitles))completion;
@end


@interface KDActionSheet : UIAlertController
+ (instancetype)JW0905showTitle:(NSString *)title message:(NSString *)message buttons:(NSArray<NSString *> *)buttons completion:(void(^)(NSUInteger index, NSString *buttonTitles))completion;

@property(nonatomic,assign)NSInteger rubish;

@end
