//
//  DZRArtist.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRArtist.h"

@implementation DZRArtist

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _artistName = dictionary[@"name"];
        _artistIdentifier = dictionary[@"id"];
        _artistPictureUrl = dictionary[@"picture"];
        _artistBigPictureUrl = dictionary[@"picture_big"];
    }
    return self;
}
@end
