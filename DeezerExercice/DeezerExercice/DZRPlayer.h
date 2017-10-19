//
//  DZRSharedPlayer.h
//  DeezerExercice
//
//  Created by Bin Chen on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DZRPlayer;
@protocol DZRPlayerDelegate <NSObject>

- (void)DZRPlayerWillBegin:(DZRPlayer *)player duration:(NSTimeInterval)duration;
- (void)DZRPlayerDidFinish:(DZRPlayer *)player;

@end
@interface DZRPlayer : NSObject

@property (nonatomic, weak) id<DZRPlayerDelegate> delegate;

+ (instancetype)sharedPlayer;

- (void)playWithUrl:(NSString *)url;
- (void)stop;
- (BOOL)isPlaying;
- (NSTimeInterval)currentTime;
- (NSTimeInterval)currentDuration;
@end
