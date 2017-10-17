//
//  DZRArtist.h
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZRParsableObject.h"

@interface DZRArtist : DZRParsableObject

@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *artistPictureUrl;

@end
