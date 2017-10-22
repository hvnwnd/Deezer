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
@property (nonatomic, weak) IBOutlet UIImageView *playImageView;
@property (nonatomic, weak) IBOutlet DZRTrackPreviewProgressView *progressView;

@end
@implementation DZRTrackTableViewCell

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"title"]) {
        self.trackTitle.text = self.viewModel.title;
    }else if ([keyPath isEqualToString:@"image"]) {
        self.playImageView.image = self.viewModel.image;
    }else if ([keyPath isEqualToString:@"isPlaying"]){
        if (self.viewModel.isPlaying){
            [self.progressView animateWithDuration:self.viewModel.duration];
        }else{
            [self.progressView reset];
        }
    }else if ([keyPath isEqualToString:@"start"]){
        if ([self.viewModel shouldResume]){
            NSLog(@"self %@", [NSThread callStackSymbols]);
            [self.progressView animateFromStart:self.viewModel.start withDuration:self.viewModel.duration];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setViewModel:(DZRTrackTableViewCellViewModel *)viewModel{
    _viewModel = viewModel;
    
    [_viewModel addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];
    [_viewModel addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];
    [_viewModel addObserver:self forKeyPath:@"isPlaying" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];
    [_viewModel addObserver:self forKeyPath:@"start" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];

}

@end
