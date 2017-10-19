//
//  DZRTrackTableViewCell.h
//  DeezerExercice
//
//  Created by Bin Chen on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZRTrackTableViewCell : UITableViewCell

- (void)updateWithTitle:(NSString *)title;
- (void)playWithDuration:(NSTimeInterval)duration;
- (void)stop;
@end
