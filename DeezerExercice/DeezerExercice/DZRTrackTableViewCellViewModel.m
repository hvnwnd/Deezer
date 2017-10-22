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

@interface DZRTrackTableViewCellViewModel()

@property (nonatomic) BOOL isPlaying;

@end
@implementation DZRTrackTableViewCellViewModel

- (instancetype)initWithTrack:(DZRTrack *)track
{
    self = [super init];
    if (self) {
        _title = track.trackTitle;
        _url = track.trackUrl;
        
        [self addObserver:self forKeyPath:@"isPlaying" options:NSKeyValueObservingOptionNew context:NULL];
        
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"isPlaying"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isPlaying"]) {
        if (self.isPlaying){
            self.image = [UIImage imageNamed:@"stop"];
            [[DZRPlayer sharedPlayer] playWithUrl:self.url];
        }else{
            self.image = [UIImage imageNamed:@"play"];
            [[DZRPlayer sharedPlayer] stop];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)play{
    self.isPlaying = YES;
}

- (void)stop
{
    self.isPlaying = NO;
}

@end
