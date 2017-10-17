//
//  DZRArtist.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRArtist.h"

@implementation DZRArtist

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        _artistName = dictionary[@"name"];
        _artistPictureUrl = dictionary[@"picture"];
    }
    return self;
}

+ (NSString *)serviceName
{
    return @"artist";
}

@end
