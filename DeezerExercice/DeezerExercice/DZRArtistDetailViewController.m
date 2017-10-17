//
//  DZRArtistDetailViewController.m
//  DeezerExercice
//
//  Created by CHEN Bin on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRArtistDetailViewController.h"
#import "DZRRequestService.h"
#import "DZRAlbum.h"
#import "DZRTrack.h"
#import "DZRTrackTableViewCell.h"
#import "DZRPlayer.h"
#import "UIImageView+Async.h"
#import "UIViewController+Error.h"

CGFloat const kDZRArtistDetailViewControllerCellHeight = 80.0;

@interface DZRArtistDetailViewController () <DZRPlayerDelegate>
@property (nonatomic, weak) IBOutlet UILabel *tableViewTitle;
@property (nonatomic, weak) IBOutlet UIImageView *cover;
@property (nonatomic) NSArray *tracks;
@property (nonatomic) DZRRequestService *requestService;

@end

@implementation DZRArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = kDZRArtistDetailViewControllerCellHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    __weak typeof (self) weakSelf = self;
    [self.requestService fetchFirstAlbumWithArtistId:self.artistId completion:^(DZRAlbum *album, NSError *error) {
        weakSelf.tableViewTitle.text = album.albumTitle;
        [weakSelf.cover setImageUrl:album.albumCoverUrl];
        
        [weakSelf.requestService fetchAlbumTracksWithAlbumId:album.identifier completion:^(NSArray *trackList, NSError *error) {
            if (trackList.count){
                weakSelf.tracks = trackList;
                [weakSelf.tableView reloadData];
            }else{
                [weakSelf showError:error];
            }
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (DZRRequestService *)requestService{
    if (!_requestService)
    {
        _requestService = [DZRRequestService new];
    }
    return _requestService;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tracks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DZRTrackTableViewCellIdentifier";
    
    DZRTrackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    DZRTrack *track = self.tracks[indexPath.row];
    [cell updateWithTitle:track.trackTitle];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DZRTrack *track = self.tracks[indexPath.row];
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
