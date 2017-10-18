//
//  NSDictionary+DZRParsable.h
//  DeezerExercice
//
//  Created by CHEN Bin on 18/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DZRParsable)

- (NSArray *)parsedArrayWithClass:(Class)cls;

@end
