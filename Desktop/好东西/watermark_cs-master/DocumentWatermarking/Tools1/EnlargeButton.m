//
//  EnlargeButton.m
//  DocumentWatermarking 909090909
//
//  Created by apple on 2017/12/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EnlargeButton.h"

@implementation EnlargeButton

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, -23, -23);
    return CGRectContainsPoint(bounds, point);
    
}
@end
