//
//  DZRTransitionManager.m
//  DeezerExercice
//
//  Created by CHEN Bin on 17/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRTransitionManager.h"
#import "DZRTransitionAnimator.h"

@implementation DZRTransitionManager

//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
//{
//    return [DZRTransitionAnimator new];
//}
//
//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
//{
//    return [DZRTransitionAnimator new];
//}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    return [DZRTransitionAnimator new];
}
@end
