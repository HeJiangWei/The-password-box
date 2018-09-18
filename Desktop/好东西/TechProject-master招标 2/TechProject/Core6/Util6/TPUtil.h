//
//  TPUtil.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TPUtil : NSObject

+ (void)showAlert:(NSString *)message;
/*
 生成唯一id
 */
+ (NSString *)generateUUID;
/*
 清除共享文件
*/
+ (void)cleanInboxFiles;
@end
