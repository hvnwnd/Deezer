//
//  DZRParsableObject.m
//  DeezerExercice
//
//  Created by CHEN Bin on 17/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRParsableObject.h"

@implementation DZRParsableObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _identifier = dictionary[@"id"];
    }
    return self;
}

+ (NSString *)serviceName
{
    NSAssert(0, @"Subclass should override this method");
    return nil;
}

@end
