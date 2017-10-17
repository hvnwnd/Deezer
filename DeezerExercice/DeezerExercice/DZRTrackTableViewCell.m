//
//  DZRTrackTableViewCell.m
//  DeezerExercice
//
//  Created by Bin Chen on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRTrackTableViewCell.h"
#import "DZRPlayBack.h"

@interface DZRTrackTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *trackTitle;
@property (nonatomic, weak) IBOutlet DZRPlayBack *playBack;

@end
@implementation DZRTrackTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithTitle:(NSString *)title
{
    self.trackTitle.text = title;
}

- (void)playWithDuration:(NSTimeInterval)duration {
    [self.playBack animateWithDuration:duration];
}

@end
