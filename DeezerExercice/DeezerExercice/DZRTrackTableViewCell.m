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

NSString *const DZRTrackTableViewCellTitleKey = @"title";
NSString *const DZRTrackTableViewCellImageKey = @"image";
NSString *const DZRTrackTableViewCellPlayingKey = @"isPlaying";
NSString *const DZRTrackTableViewCellStartKey = @"start";

@interface DZRTrackTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *trackTitle;
@property (nonatomic, weak) IBOutlet UIImageView *playImageView;
@property (nonatomic, weak) IBOutlet DZRTrackPreviewProgressView *progressView;

@end
@implementation DZRTrackTableViewCell

- (void)dealloc
{
    [self.viewModel removeObserver:self forKeyPath:DZRTrackTableViewCellTitleKey];
    [self.viewModel removeObserver:self forKeyPath:DZRTrackTableViewCellImageKey];
    [self.viewModel removeObserver:self forKeyPath:DZRTrackTableViewCellPlayingKey];
    [self.viewModel removeObserver:self forKeyPath:DZRTrackTableViewCellStartKey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:DZRTrackTableViewCellTitleKey]) {
        self.trackTitle.text = self.viewModel.title;
    }else if ([keyPath isEqualToString:DZRTrackTableViewCellImageKey]) {
        self.playImageView.image = self.viewModel.image;
    }else if ([keyPath isEqualToString:DZRTrackTableViewCellPlayingKey]){
        if (self.viewModel.isPlaying){
            [self.progressView animateWithDuration:self.viewModel.duration];
        }else{
            [self.progressView reset];
        }
    }else if ([keyPath isEqualToString:DZRTrackTableViewCellStartKey]){
        if ([self.viewModel shouldResume]){
            [self.progressView animateFromStart:self.viewModel.start withDuration:self.viewModel.duration];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setViewModel:(DZRTrackTableViewCellViewModel *)viewModel{
    _viewModel = viewModel;
    [_viewModel addObserver:self forKeyPath:DZRTrackTableViewCellTitleKey options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];
    [_viewModel addObserver:self forKeyPath:DZRTrackTableViewCellImageKey options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];
    [_viewModel addObserver:self forKeyPath:DZRTrackTableViewCellPlayingKey options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];
    [_viewModel addObserver:self forKeyPath:DZRTrackTableViewCellStartKey options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];

}

@end
