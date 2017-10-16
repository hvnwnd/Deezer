//
//  DZRRequestService.h
//  DeezerExercice
//
//  Created by CHEN Bin on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZRRequestService : NSObject

- (void)searchArtistWithText:(NSString *)text
                  completion:(void(^)(NSArray *result, NSError *error))completion;

@end
