//
//  DZRAlbum.m
//  DeezerExercice
//
//  Created by CHEN Bin on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRAlbum.h"

@implementation DZRAlbum

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        _albumTitle = dictionary[@"title"];
        _albumCoverUrl = dictionary[@"cover"];
    }
    return self;
}

+ (NSString *)serviceName
{
    return @"album";
}

@end
