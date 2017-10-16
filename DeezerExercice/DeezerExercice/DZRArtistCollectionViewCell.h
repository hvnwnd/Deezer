//
//  DZRArtistCollectionViewCell.h
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZRArtistCollectionViewCell : UICollectionViewCell

@property (nonatomic, readonly) NSString *artistId;
@property (nonatomic, readonly) NSString *artistName;

- (void)updateWithArtistId:(NSString *)artistId
                      name:(NSString *)name
              imageUrl:(NSString *)imageUrl;
@end
