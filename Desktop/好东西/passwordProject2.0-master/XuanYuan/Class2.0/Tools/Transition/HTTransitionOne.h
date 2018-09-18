//
//  HTTransitionOne.h
//  map_yang
//
//  Created by niesiyang-worker on 2017/11/17.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HTTransitionOne : NSObject<UIViewControllerAnimatedTransitioning>
- (instancetype)initWithOperation:(BOOL)isPush;
@end
