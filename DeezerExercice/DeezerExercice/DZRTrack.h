//
//  DZRTrack.h
//  DeezerExercice
//
//  Created by Bin Chen on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZRTrack : NSObject

@property (nonatomic) NSString *trackIdentifier;
@property (nonatomic) NSString *trackTitle;
@property (nonatomic) NSString *trackUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
