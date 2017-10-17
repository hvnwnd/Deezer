//
//  DZRTransitionAnimator.m
//  DeezerExercice
//
//  Created by CHEN Bin on 17/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRTransitionAnimator.h"

static CGFloat const kChildViewPadding = 16;
static CGFloat const kDamping = 0.75f;
static CGFloat const kInitialSpringVelocity = 0.5f;

@implementation DZRTransitionAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
//    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//
//    // When sliding the views horizontally, in and out, figure out whether we are going left or right.
//    BOOL goingRight = ([transitionContext initialFrameForViewController:toViewController].origin.x < [transitionContext finalFrameForViewController:toViewController].origin.x);
//
//    CGFloat travelDistance = [transitionContext containerView].bounds.size.width + kChildViewPadding;
//    CGAffineTransform travel = CGAffineTransformMakeTranslation (goingRight ? travelDistance : -travelDistance, 0);
//    [[transitionContext containerView] addSubview:toViewController.view];
//    toViewController.view.alpha = 0;
//    toViewController.view.transform = CGAffineTransformInvert (travel);
//    travel = CGAffineTransformScale(travel, 10, 10);
//
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:kDamping initialSpringVelocity:kInitialSpringVelocity options:0 animations:^{
//        fromViewController.view.transform = travel;
//        fromViewController.view.alpha = 0;
//        toViewController.view.transform = CGAffineTransformIdentity;
//        toViewController.view.alpha = 1;
//    } completion:^(BOOL finished) {
//        fromViewController.view.transform = CGAffineTransformIdentity;
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//    }];
    
    //https://github.com/KittenYang/KYPushTransition/blob/master/KYPushTransitionDemo/KYPushTransitionDemo/KYPushTransition.m
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
    
    //增加透视的transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
    
    //给fromVC和toVC分别设置相同的起始frame
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    fromView.frame = initialFrame;
    toView.frame = initialFrame;
    
    [self updateAnchorPointAndOffset:CGPointMake(0.0, 0.5) view:fromView];
    
    //增加阴影
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = fromView.bounds;
    gradient.colors = @[(id)[UIColor colorWithWhite:0.0 alpha:0.5].CGColor,
                        (id)[UIColor colorWithWhite:0.0 alpha:0.0].CGColor];
    gradient.startPoint = CGPointMake(0.0, 0.5);
    gradient.endPoint = CGPointMake(0.8, 0.5);
    
    UIView *shadow = [[UIView alloc]initWithFrame:fromView.bounds];
    shadow.backgroundColor = [UIColor clearColor];
    [shadow.layer insertSublayer:gradient atIndex:1];
    shadow.alpha = 0.0;
    
    [fromView addSubview:shadow];
    
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        //旋转fromView 90度
        fromView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1.0, 0);
        shadow.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        fromView.layer.position    = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        fromView.layer.transform = CATransform3DIdentity;
        [shadow removeFromSuperview];
        [transitionContext completeTransition:YES];
        
    }];

}

-(void)updateAnchorPointAndOffset:(CGPoint)anchorPoint view:(UIView *)view{
    view.layer.anchorPoint = anchorPoint;
    view.layer.position    = CGPointMake(0, CGRectGetMidY([UIScreen mainScreen].bounds));
}

@end
