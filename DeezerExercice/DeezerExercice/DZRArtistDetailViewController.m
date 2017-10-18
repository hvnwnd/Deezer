//
//  DZRArtistDetailViewController.m
//  DeezerExercice
//
//  Created by CHEN Bin on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRArtistDetailViewController.h"
#import "DZRAlbum.h"
#import "DZRTrack.h"
#import "DZRTrackTableViewCell.h"
#import "DZRPlayer.h"
#import "UIImageView+Async.h"
#import "UIViewController+Error.h"
#import "DZRArtistDetailViewModel.h"

CGFloat const kDZRArtistDetailViewControllerCellHeight = 80.0;
NSString *const kDZRArtistDetailViewControllerAlbumKey = @"album";
NSString *const kDZRArtistDetailViewControllerTracksKey = @"tracks";
NSString *const kDZRArtistDetailViewControllerErrorKey = @"error";

@interface DZRArtistDetailViewController () <DZRPlayerDelegate>
@property (nonatomic, weak) IBOutlet UILabel *tableViewTitle;
@property (nonatomic, weak) IBOutlet UIImageView *cover;

@property (nonatomic) NSArray *tracks;

@property (nonatomic) DZRArtistDetailViewModel *viewModel;
@end

@implementation DZRArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = kDZRArtistDetailViewControllerCellHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.viewModel fetchFirstAlbumWithArtistId:self.artistId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accessors

- (DZRArtistDetailViewModel *)viewModel{
    if (!_viewModel){
        _viewModel = [DZRArtistDetailViewModel new];
        [_viewModel addObserver:self forKeyPath:kDZRArtistDetailViewControllerAlbumKey options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:NULL];
        [_viewModel addObserver:self forKeyPath:kDZRArtistDetailViewControllerTracksKey options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:NULL];
        [_viewModel addObserver:self forKeyPath:kDZRArtistDetailViewControllerErrorKey options:NSKeyValueObservingOptionNew context:NULL];
    }
    
    return _viewModel;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:kDZRArtistDetailViewControllerAlbumKey]){
        self.tableViewTitle.text = self.viewModel.album.albumTitle;
        [self.cover setImageUrl:self.viewModel.album.albumCoverUrl];
    }else if ([keyPath isEqualToString:kDZRArtistDetailViewControllerTracksKey]) {
        [self.tableView reloadData];
    } else if ([keyPath isEqualToString:kDZRArtistDetailViewControllerErrorKey]){
        [self showError:self.viewModel.error];
    } else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc{
    [self.viewModel removeObserver:self forKeyPath:kDZRArtistDetailViewControllerAlbumKey];
    [self.viewModel removeObserver:self forKeyPath:kDZRArtistDetailViewControllerTracksKey];
    [self.viewModel removeObserver:self forKeyPath:kDZRArtistDetailViewControllerErrorKey];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.tracks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DZRTrackTableViewCellIdentifier";
    
    DZRTrackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    DZRTrack *track = self.viewModel.tracks[indexPath.row];
    [cell updateWithTitle:track.trackTitle];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DZRTrack *track = self.viewModel.tracks[indexPath.row];
    [[DZRPlayer sharedPlayer] playWithUrl:track.trackUrl];
    
    [DZRPlayer sharedPlayer].delegate = self;
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(pausePlayer:)];
}

- (void)pausePlayer:(id)sender{
    [[DZRPlayer sharedPlayer] stop];
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)DZRPlayerWillBegin:(DZRPlayer *)player duration:(NSTimeInterval)duration{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    DZRTrackTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell playWithDuration:duration];
}
@end
