//
//  DZRTransitionManager.m
//  DeezerExercice
//
//  Created by CHEN Bin on 17/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRTransitionManager.h"

#import "DZRPushTransitionAnimator.h"
#import "DZRPopTransitionAnimator.h"

@implementation DZRTransitionManager

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush){
        return [DZRPushTransitionAnimator new];
    }else{
        return [DZRPopTransitionAnimator new];
    }
}
@end
