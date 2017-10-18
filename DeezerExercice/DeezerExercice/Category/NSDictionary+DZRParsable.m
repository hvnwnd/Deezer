//
//  NSDictionary+DZRParsable.m
//  DeezerExercice
//
//  Created by CHEN Bin on 18/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "NSDictionary+DZRParsable.h"
#import "DZRParsable.h"

@implementation NSDictionary (DZRParsable)

- (NSArray *)parsedArrayWithClass:(Class)cls
{
    NSMutableArray *parsedObjects = [NSMutableArray array];
    for (NSDictionary *objectDict in self[@"data"]) {
        
        id<DZRParsable> obj = [[(Class)cls alloc] initWithDictionary:objectDict];
        [parsedObjects addObject:obj];
    }
    return parsedObjects;

}
@end

