//
//  DZRTrack.m
//  DeezerExercice
//
//  Created by Bin Chen on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRTrack.h"

@implementation DZRTrack

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _trackIdentifier = dictionary[@"id"];
        _trackTitle = dictionary[@"title"];
        _trackUrl = dictionary[@"preview"];
    }
    return self;
}

@end
