//
//  DZRTrackTableViewCellViewModel.m
//  DeezerExercice
//
//  Created by Bin Chen on 22/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRTrackTableViewCellViewModel.h"
#import "DZRTrack.h"
#import "DZRPlayer.h"

NSString *const DZRTrackTableViewCellViewModelPlayFinishNotification = @"DZRTrackTableViewCellViewModelPlayFinishNotification";
@interface DZRTrackTableViewCellViewModel() <DZRPlayerDelegate>

@end
@implementation DZRTrackTableViewCellViewModel

- (instancetype)initWithTrack:(DZRTrack *)track
{
    self = [super init];
    if (self) {
        _title = track.trackTitle;
        _url = track.trackUrl;
        _image = [UIImage imageNamed:@"play"];
    }
    return self;
}

- (void)play{
    self.image = [UIImage imageNamed:@"stop"];
    [[DZRPlayer sharedPlayer] playWithUrl:self.url];
    [DZRPlayer sharedPlayer].delegate = self;
}

- (void)stop
{
    self.image = [UIImage imageNamed:@"play"];
    [[DZRPlayer sharedPlayer] stop];
    self.isPlaying = NO;
    self.start = 0.0;
    [[NSNotificationCenter defaultCenter] postNotificationName:DZRTrackTableViewCellViewModelPlayFinishNotification object:nil];
}

- (void)updateTrackStart
{
    self.start = [DZRPlayer sharedPlayer].currentTime;
}

- (void)delayedSetValue{
}

- (BOOL)shouldResume
{
    return self.start > 0;
}

- (void)DZRPlayerWillBegin:(DZRPlayer *)player duration:(NSTimeInterval)duration{
    self.duration = duration;
    self.isPlaying = YES;
}

- (void)DZRPlayerDidFinish:(DZRPlayer *)player
{
    [self stop];
}

@end
