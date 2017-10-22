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
- (void)animateFromStart:(NSTimeInterval)start withDuration:(NSTimeInterval)duration{
    CGFloat lineWidth = 3.0;
    
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
    pathAnimation.duration = (duration - start);
    pathAnimation.fromValue = @(start/duration);
    pathAnimation.toValue = @(1.0f);
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];

}

- (void)animateWithDuration:(NSTimeInterval)duration{
    [self animateFromStart:0.0 withDuration:duration];
}
- (void)reset
{
    [self.pathLayer removeAllAnimations];
    [self.pathLayer removeFromSuperlayer];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self reset];
}

@end
