//
//  DZRArtistCollectionViewCell.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRArtistCollectionViewCell.h"
#import "UIImageView+Async.h"
@interface DZRArtistCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *artistImage;
@property (weak, nonatomic) IBOutlet UILabel *artistName;

@end
@implementation DZRArtistCollectionViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.artistImage.image = nil;
}

- (void)updateWithName:(NSString *)name
              imageUrl:(NSString *)imageUrl
{
    self.artistName.text = name;
    [self.artistImage setImageUrl:imageUrl];
}

@end
