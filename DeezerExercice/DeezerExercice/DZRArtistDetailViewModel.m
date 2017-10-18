//
//  DZRArtistDetailViewModel.m
//  DeezerExercice
//
//  Created by Bin Chen on 18/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRArtistDetailViewModel.h"
#import "DZRRequestService.h"
#import "DZRAlbum.h"

@interface DZRArtistDetailViewModel()

@property (nonatomic) DZRRequestService *requestService;

@end

@implementation DZRArtistDetailViewModel

- (DZRRequestService *)requestService{
    if (!_requestService)
    {
        _requestService = [DZRRequestService new];
    }
    return _requestService;
}

- (void)fetchFirstAlbumWithArtistId:(NSString *)identifier{
    __weak typeof (self) weakSelf = self;

    [self.requestService fetchFirstAlbumWithArtistId:identifier completion:^(NSArray *albums, NSError *error) {
        if (error){
            weakSelf.error = error;
        }else{
            weakSelf.album = albums.firstObject;
            [weakSelf.requestService fetchAlbumTracksWithAlbumId:weakSelf.album.identifier completion:^(NSArray *trackList, NSError *error) {
                if (trackList.count){
                    weakSelf.tracks = trackList;
                }else{
                    weakSelf.error = error;
                }
            }];
        }
    }];
}
@end
