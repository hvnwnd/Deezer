//
//  DZRTransitionAnimator.m
//  DeezerExercice
//
//  Created by CHEN Bin on 17/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRPopTransitionAnimator.h"

@implementation DZRPopTransitionAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
    
    fromView.layer.anchorPoint = CGPointMake(1.0, 0.5);
    fromView.layer.position    = CGPointMake(CGRectGetMaxX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        fromView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1.0, 0);
        
    } completion:^(BOOL finished) {
        fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        fromView.layer.position    = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        fromView.layer.transform = CATransform3DIdentity;
        [transitionContext completeTransition:YES];
    }];

}

@end
