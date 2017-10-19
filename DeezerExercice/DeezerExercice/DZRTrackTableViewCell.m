//
//  DZRTrackTableViewCell.m
//  DeezerExercice
//
//  Created by Bin Chen on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRTrackTableViewCell.h"
#import "DZRTrackPreviewProgressView.h"

@interface DZRTrackTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *trackTitle;
@property (nonatomic, weak) IBOutlet DZRTrackPreviewProgressView *progressView;
@property (nonatomic, weak) IBOutlet UIImageView *playImageView;

@end
@implementation DZRTrackTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

- (void)showPlayingFromStart:(NSTimeInterval)start duration:(NSTimeInterval)duration
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
