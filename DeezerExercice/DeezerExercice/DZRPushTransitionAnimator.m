//
//  DZRPopTransitionAnimator.m
//  DeezerExercice
//
//  Created by CHEN Bin on 18/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRPushTransitionAnimator.h"

@implementation DZRPushTransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.6;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
    
    toView.layer.anchorPoint = CGPointMake(1.0, 0.5);
    toView.layer.position    = CGPointMake(CGRectGetMaxX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
    toView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0.0, 1.0, 0.0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        toView.layer.transform = CATransform3DMakeRotation(0, 0, 1.0, 0);
    } completion:^(BOOL finished) {
        
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.position    = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}

-(void)updateAnchorPointAndOffset:(CGPoint)anchorPoint view:(UIView *)view{
    view.layer.anchorPoint = anchorPoint;
    view.layer.position    = CGPointMake(CGRectGetMaxX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
}

@end
