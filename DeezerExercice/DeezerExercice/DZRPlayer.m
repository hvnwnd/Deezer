//
//  DZRSharedPlayer.m
//  DeezerExercice
//
//  Created by Bin Chen on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRPlayer.h"
@import AVFoundation;
@import AudioToolbox;

@interface DZRPlayer ()

@property (nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation DZRPlayer

+ (instancetype)sharedPlayer
{
    static DZRPlayer *player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[self alloc] init];
    });
    return player;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)playWithUrl:(NSString *)url{
    [self.audioPlayer stop];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSError *error = nil;

        self.audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&error];
        if (self.delegate){
            [self.delegate DZRPlayerWillBegin:self duration:self.audioPlayer.duration];
        }
        [self.audioPlayer play];
    }];
}

- (void)stop{
    [self.audioPlayer stop];
    self.audioPlayer = nil;
}

- (BOOL)isPlaying{
    return self.audioPlayer.playing;
}
@end
