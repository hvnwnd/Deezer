//
//  DZRTrackTableViewCell.m
//  DeezerExercice
//
//  Created by Bin Chen on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRTrackTableViewCell.h"
#import "DZRTrackPreviewProgressView.h"
#import "DZRTrackTableViewCellViewModel.h"

@interface DZRTrackTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *trackTitle;
@property (nonatomic, weak) IBOutlet DZRTrackPreviewProgressView *progressView;
@property (nonatomic, weak) IBOutlet UIImageView *playImageView;

@end
@implementation DZRTrackTableViewCell

- (void)setViewModel:(DZRTrackTableViewCellViewModel *)viewModel{
    _viewModel = viewModel;
    self.trackTitle.text = viewModel.title;

}

- (void)updateWithTitle:(NSString *)title
{
    self.trackTitle.text = title;
}

- (void)playWithDuration:(NSTimeInterval)duration {
    [self.progressView animateWithDuration:duration];
    self.playImageView.image = [UIImage imageNamed:@"stop"];
    self.isPlaying = YES;
}

- (void)resumeAnimationFrom:(NSTimeInterval)start duration:(NSTimeInterval)duration
{
    [self.progressView animateFromStart:start withDuration:duration];
    self.playImageView.image = [UIImage imageNamed:@"stop"];
    self.isPlaying = YES;
}

- (void)stop
{
    [self.progressView reset];
    self.playImageView.image = [UIImage imageNamed:@"play"];
    self.isPlaying = NO;
}

@end
