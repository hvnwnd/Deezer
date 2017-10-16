//
//  DZRArtistCollectionViewCell.h
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZRArtistCollectionViewCell : UICollectionViewCell

- (void)updateWithName:(NSString *)name
              imageUrl:(NSString *)imageUrl;
@end
