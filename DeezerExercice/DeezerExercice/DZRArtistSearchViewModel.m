//
//  DZRArtistSearchViewModel.m
//  DeezerExercice
//
//  Created by Bin Chen on 18/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRArtistSearchViewModel.h"
#import "DZRRequestService.h"

@interface DZRArtistSearchViewModel()

@property (nonatomic) DZRRequestService *requestService;

@end
@implementation DZRArtistSearchViewModel

- (DZRRequestService *)requestService{
    if (!_requestService)
    {
        _requestService = [DZRRequestService new];
    }
    return _requestService;
}

- (void)searchWithText:(NSString *)text{
    __weak typeof (self) weakSelf = self;
    [self.requestService searchArtistWithText:text completion:^(NSArray *result, NSError *error) {
        if (result){
            weakSelf.searchResult = result;
        }else{
            weakSelf.error = error;
        }
    }];
}

@end
