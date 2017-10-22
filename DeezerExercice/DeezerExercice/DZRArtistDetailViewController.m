//
//  DZRArtistDetailViewController.m
//  DeezerExercice
//
//  Created by CHEN Bin on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRArtistDetailViewController.h"
#import "DZRAlbum.h"
#import "DZRTrackTableViewCell.h"
#import "UIImageView+Async.h"
#import "UIViewController+Error.h"
#import "DZRArtistDetailViewModel.h"
#import "DZRTrackTableViewCellViewModel.h"

CGFloat const kDZRArtistDetailViewControllerCellHeight = 80.0;
NSString *const kDZRArtistDetailViewControllerAlbumKey = @"album";
NSString *const kDZRArtistDetailViewControllerTracksKey = @"trackViewModels";
NSString *const kDZRArtistDetailViewControllerErrorKey = @"error";

@interface DZRArtistDetailViewController ()
@property (nonatomic, weak) IBOutlet UILabel *tableViewTitle;
@property (nonatomic, weak) IBOutlet UIImageView *cover;

@property (nonatomic) DZRArtistDetailViewModel *viewModel;
@property (nonatomic) NSIndexPath *currentSelectedIndexPath;
@end

@implementation DZRArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = kDZRArtistDetailViewControllerCellHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.viewModel fetchFirstAlbumWithArtistId:self.artistId];
    
    __weak typeof (self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:DZRTrackTableViewCellViewModelPlayFinishNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification * _Nonnull note) {
        weakSelf.currentSelectedIndexPath = nil;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.viewModel removeObserver:self forKeyPath:kDZRArtistDetailViewControllerAlbumKey];
    [self.viewModel removeObserver:self forKeyPath:kDZRArtistDetailViewControllerTracksKey];
    [self.viewModel removeObserver:self forKeyPath:kDZRArtistDetailViewControllerErrorKey];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.trackViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DZRTrackTableViewCellIdentifier";
    DZRTrackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    DZRTrackTableViewCellViewModel *cellModel = self.viewModel.trackViewModels[indexPath.row];
    cell.viewModel = cellModel;
    if ([indexPath isEqual:self.currentSelectedIndexPath]){
        [cellModel updateTrackStart];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BOOL sameIndexPath = [self.currentSelectedIndexPath isEqual:indexPath];
    DZRTrackTableViewCellViewModel *oldCellModel = self.viewModel.trackViewModels[self.currentSelectedIndexPath.row];
    if (oldCellModel.isPlaying){
        [oldCellModel stop];
    }
    
    if (!sameIndexPath){
        self.currentSelectedIndexPath = indexPath;
        DZRTrackTableViewCellViewModel *newCellModel = self.viewModel.trackViewModels[indexPath.row];
        [newCellModel play];
    }
}

@end
