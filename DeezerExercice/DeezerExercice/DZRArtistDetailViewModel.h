//
//  DZRArtistDetailViewModel.h
//  DeezerExercice
//
//  Created by Bin Chen on 18/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DZRAlbum;

@interface DZRArtistDetailViewModel : NSObject

@property (nonatomic) DZRAlbum *album;
@property (nonatomic) NSArray *tracks;
@property (nonatomic) NSError *error;

- (void)fetchFirstAlbumWithArtistId:(NSString *)identifier;

@end
