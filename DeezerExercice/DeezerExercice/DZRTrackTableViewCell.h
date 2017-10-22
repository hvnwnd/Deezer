//
//  DZRTrackTableViewCell.h
//  DeezerExercice
//
//  Created by Bin Chen on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZRTrackTableViewCellViewModel;
@interface DZRTrackTableViewCell : UITableViewCell

@property (nonatomic) DZRTrackTableViewCellViewModel *viewModel;
@property (nonatomic) BOOL isPlaying;
- (void)updateWithTitle:(NSString *)title;
- (void)playWithDuration:(NSTimeInterval)duration;
- (void)stop;
- (void)resumeAnimationFrom:(NSTimeInterval)start duration:(NSTimeInterval)duration;
@end
