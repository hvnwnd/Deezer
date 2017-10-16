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
#import "UIImageView+Async.h"

@interface DZRArtistDetailViewController ()
@property (nonatomic, weak) IBOutlet UILabel *tableViewTitle;
@property (nonatomic, weak) IBOutlet UIImageView *cover;

@property (nonatomic) DZRRequestService *requestService;

@end

@implementation DZRArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof (self) weakSelf = self;
    [self.requestService searchFirstAlbumWithArtistId:self.artistId completion:^(DZRAlbum *album, NSError *error) {
        weakSelf.tableViewTitle.text = album.albumTitle;
        [weakSelf.cover setImageUrl:album.albumCoverUrl];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
