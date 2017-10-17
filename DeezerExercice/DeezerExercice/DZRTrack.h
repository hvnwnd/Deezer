//
//  DZRTrack.h
//  DeezerExercice
//
//  Created by Bin Chen on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZRParsableObject.h"

@interface DZRTrack : DZRParsableObject

@property (nonatomic) NSString *trackTitle;
@property (nonatomic) NSString *trackUrl;

@end
