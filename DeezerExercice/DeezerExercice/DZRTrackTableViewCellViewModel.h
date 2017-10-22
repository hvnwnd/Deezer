//
//  DZRTrackTableViewCellViewModel.h
//  DeezerExercice
//
//  Created by Bin Chen on 22/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const DZRTrackTableViewCellViewModelPlayFinishNotification;
@class DZRTrack;

@interface DZRTrackTableViewCellViewModel : NSObject

@property (nonatomic) BOOL isPlaying;
@property (nonatomic) NSTimeInterval start;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *url;
@property (nonatomic) UIImage *image;

- (instancetype)initWithTrack:(DZRTrack *)track;
- (void)play;
- (void)stop;
- (BOOL)shouldResume;
- (void)updateTrackStart;
@end
