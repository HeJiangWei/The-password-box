//
//  TPExcelManager.h
//  TechProject
//
//  Created b
//  Copyright © 2018年 1122zhengjiacheng. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kTPDidReadExcelContentNotification;
extern NSString *const kTPProjectAddFileName;
extern NSString *const kTPClientAddFileName;
extern NSString *const kTPInitialProjectFileName;
extern NSString *const kTPInitialClientFileName;

@interface TPExcelManager : NSObject

+ (instancetype)shareInstance;

- (NSDictionary *)readExcelContent:(NSString *)path;
@end
