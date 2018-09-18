//
//  HTTransitionOne.m
//  map_yang
//
//  Created by niesiyang-worker on 2017/11/17.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTTransitionOne.h"

@interface HTTransitionOne()
@property (nonatomic,assign) BOOL isPush;

@end

@implementation HTTransitionOne

- (instancetype)initWithOperation:(BOOL)isPush
{
    self = [super init];
    if (self) {
        _isPush = isPush;
    }
    return self;
}


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (_isPush) {
        UIViewController *formVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVc   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        CGRect finalFrameForVc   = [transitionContext finalFrameForViewController:toVc];
        CGRect bounds            = [UIScreen mainScreen].bounds;
        toVc.view.frame          = CGRectOffset(finalFrameForVc, 0, bounds.size.height);
        [[transitionContext containerView] addSubview:toVc.view];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            formVc.view.alpha = 0.8;
            toVc.view.frame   = finalFrameForVc;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
            formVc.view.alpha = 1.0;
        }];
    }
    else
    {

    }

}

@end
