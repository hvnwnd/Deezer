//
//  DZRRequestService.h
//  DeezerExercice
//
//  Created by CHEN Bin on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DZRAlbum;
@class DZRArtist;
@class DZRTrack;

@interface DZRRequestService : NSObject

- (void)searchArtistWithText:(NSString *)text
                  completion:(void(^)(NSArray<DZRArtist *> *artists, NSError *error))completion;

- (void)fetchFirstAlbumWithArtistId:(NSString *)artistId
                          completion:(void(^)(NSArray<DZRAlbum *> *albums, NSError *error))completion;

- (void)fetchAlbumTracksWithAlbumId:(NSString *)albumId
                         completion:(void(^)(NSArray<DZRTrack *> *tracks, NSError *error))completion;

@end
