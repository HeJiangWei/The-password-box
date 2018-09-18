//
//  HTProgressHUD.h
//  map_yang
//
//  Created by niesiyang on 2017/11/8.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>

@interface HTProgressHUD : NSObject

+(void)showMessage:(NSString *)message forView:(UIView *)view;

+(MBProgressHUD *)LoadingShowMessage:(NSString *)message
                    andDetailMessage:(NSString *)detailMessage
                             forView:(UIView *)view
                       clickedCancel:(void (^)(void))cancel;

+(MBProgressHUD *)LoadingShowMessage:(NSString *)message
                    andDetailMessage:(NSString *)detailMessage
                             forView:(UIView *)view;

+(MBProgressHUD *)LoadingShowMessage:(NSString *)message
                             forView:(UIView *)view;

+(MBProgressHUD *)LoadingShowMessage:(NSString *)message;

+(void)HiddenForView:(UIView *)view;
+(void)Hidden;

@end
