//
//  UIImageView+Async.m
//  DeezerExercice
//
//  Created by CHEN Bin on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "UIImageView+Async.h"

CGFloat const kUIImageViewAnimationDuration = 0.3f;

@implementation UIImageView (Async)

- (void)setImageUrl:(NSString *)urlString
{
    //TODO : Cache, loader, placeholder
    __weak typeof (self) weakSelf = self;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        [UIView transitionWithView:weakSelf
                          duration:kUIImageViewAnimationDuration
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            weakSelf.image = [UIImage imageWithData:data];
                        } completion:nil];
    }];
}

@end
