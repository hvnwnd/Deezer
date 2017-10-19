//
//  DZRPlayBack.m
//  DeezerExercice
//
//  Created by Bin Chen on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRTrackPreviewProgressView.h"
@import QuartzCore;

@interface DZRTrackPreviewProgressView()<CAAnimationDelegate>

@property (nonatomic, weak) CAShapeLayer *pathLayer;

@end
@implementation DZRTrackPreviewProgressView

- (UIBezierPath *)roundPath {
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));

    UIBezierPath *roundPath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                             radius:CGRectGetMidX(self.bounds) - 1.0
                                                         startAngle:-M_PI_2
                                                           endAngle:M_PI_2 * 3
                                                          clockwise:YES];
    return roundPath;
}

- (void)animateWithDuration:(NSTimeInterval)duration{
    CGFloat lineWidth = 2.0;

    if (!self.pathLayer){
        CAShapeLayer *layer = [CAShapeLayer layer];
        self.pathLayer = layer;
        layer.lineWidth = lineWidth;
        layer.backgroundColor = [UIColor grayColor].CGColor;
        layer.strokeColor = [UIColor redColor].CGColor;
        layer.fillColor = nil;
        layer.lineJoin = kCALineJoinBevel;
        layer.path = [self roundPath].CGPath;
        
    }
    [self.layer addSublayer:self.pathLayer];

    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.delegate = self;
    pathAnimation.duration = duration;
    pathAnimation.fromValue = @(0.0f);
    pathAnimation.toValue = @(1.0f);
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.pathLayer removeFromSuperlayer];
}

@end
