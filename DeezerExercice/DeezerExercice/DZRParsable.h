//
//  DZRParsable.h
//  DeezerExercice
//
//  Created by CHEN Bin on 17/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DZRParsable <NSObject>

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSString *)serviceName;

@end
