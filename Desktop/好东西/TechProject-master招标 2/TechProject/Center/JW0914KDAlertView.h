//
//  JW0914KDAlertView.h
//  BaseWebFoundation
//
//  Created by xiao6 on JW0914/12/13.
//  Copyright © JW0914年 JW0914. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JW0914KDAlertView : UIAlertController
+ (instancetype)JW0914showTitle:(NSString *)title message:(NSString *)message buttons:(NSArray<NSString *> *)buttons completion:(void(^)(NSUInteger index, NSString *buttonTitles))completion;
@end


@interface KDActionSheet : UIAlertController
+ (instancetype)JW0914showTitle:(NSString *)title message:(NSString *)message buttons:(NSArray<NSString *> *)buttons completion:(void(^)(NSUInteger index, NSString *buttonTitles))completion;

@property(nonatomic,assign)NSInteger rubish;

@end
