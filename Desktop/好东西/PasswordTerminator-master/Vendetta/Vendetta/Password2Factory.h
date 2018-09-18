//
//  Password2Factory.h
//  Vendetta
//
//  Created byjw chen JW on 15/8/19.
//  Copyright (c) 2018年 chen Yuheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Encryp2tion.h"

@interface Password2Factory : NSObject

+ (NSString *)passwordWithLength:(NSInteger)length
                   withUppercase:(BOOL)uppercase
           withSpecialCharacters:(BOOL)withSpecialChrac;
@end
