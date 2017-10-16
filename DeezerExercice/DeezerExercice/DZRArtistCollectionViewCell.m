//
//  DZRArtistCollectionViewCell.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRArtistCollectionViewCell.h"
#import "UIImageView+Async.h"
@interface DZRArtistCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *artistImage;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (nonatomic, readwrite) NSString *artistId;
@property (nonatomic, readwrite) NSString *artistName;

@end

@implementation DZRArtistCollectionViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.artistImage.image = nil;
}

- (void)updateWithArtistId:(NSString *)artistId
                      name:(NSString *)name
                  imageUrl:(NSString *)imageUrl
{
    self.artistId = artistId;
    self.artistName = name;
    self.artistNameLabel.text = name;
    [self.artistImage setImageUrl:imageUrl];
}

@end
