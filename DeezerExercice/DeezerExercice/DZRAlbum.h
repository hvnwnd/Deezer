//
//  DZRAlbum.h
//  DeezerExercice
//
//  Created by CHEN Bin on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZRParsableObject.h"

@interface DZRAlbum : DZRParsableObject

@property (nonatomic, strong) NSString *albumTitle;
@property (nonatomic, strong) NSString *albumCoverUrl;

@end
