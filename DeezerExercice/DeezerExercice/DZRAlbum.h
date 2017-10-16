//
//  DZRAlbum.h
//  DeezerExercice
//
//  Created by CHEN Bin on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZRAlbum : NSObject

@property (nonatomic, strong) NSString *albumIdentifier;
@property (nonatomic, strong) NSString *albumTitle;
@property (nonatomic, strong) NSString *albumCoverUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
