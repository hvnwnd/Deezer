//
//  DZRArtistSearchViewModel.h
//  DeezerExercice
//
//  Created by Bin Chen on 18/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZRArtistSearchViewModel : NSObject

@property (nonatomic) NSArray *searchResult;
@property (nonatomic) NSError *error;

- (void)searchWithText:(NSString *)text;

@end
