//
//  JW0732KDAlertView.h
//  BaseWebFoundation
//
//  Created by xiao6 on JW0732/12/13.
//  Copyright © JW0732年 JW0732. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JW0732KDAlertView : UIAlertController
+ (instancetype)JW0732showTitle:(NSString *)title message:(NSString *)message buttons:(NSArray<NSString *> *)buttons completion:(void(^)(NSUInteger index, NSString *buttonTitles))completion;
@end


@interface KDActionSheet : UIAlertController
+ (instancetype)JW0732showTitle:(NSString *)title message:(NSString *)message buttons:(NSArray<NSString *> *)buttons completion:(void(^)(NSUInteger index, NSString *buttonTitles))completion;

@property(nonatomic,assign)NSInteger rubish;

@end
