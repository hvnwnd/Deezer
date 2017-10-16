//
//  DZRSharedPlayer.h
//  DeezerExercice
//
//  Created by Bin Chen on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZRPlayer : NSObject

+ (instancetype)sharedPlayer;

- (void)playWithUrl:(NSString *)url;
- (void)stop;
- (BOOL)isPlaying;
@end
