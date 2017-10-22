//
//  DZRTrackTableViewCellViewModel.h
//  DeezerExercice
//
//  Created by Bin Chen on 22/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZRTrack;

@interface DZRTrackTableViewCellViewModel : NSObject

@property (nonatomic) NSTimeInterval start;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *url;
@property (nonatomic) UIImage *image;

- (instancetype)initWithTrack:(DZRTrack *)track;
- (void)play;
- (void)stop;
@end
