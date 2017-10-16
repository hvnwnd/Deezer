//
//  DZRRequestService.m
//  DeezerExercice
//
//  Created by CHEN Bin on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRRequestService.h"
#import "DZRArtist.h"

NSString *const kDZRBaseURL = @"https://api.deezer.com/";

@implementation DZRRequestService

- (void)searchArtistWithText:(NSString *)text completion:(void(^)(NSArray *result, NSError *error))completion
{
    NSString *urlRequest = [NSString stringWithFormat:@"%@/search/artist?q=%@", kDZRBaseURL, text];
    NSURLRequest *APIRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlRequest]];
    
    [NSURLConnection sendAsynchronousRequest:APIRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError) {
                                   completion(nil, connectionError);
                               } else {
                                   NSDictionary *retData = [NSJSONSerialization JSONObjectWithData:data
                                                                                           options:kNilOptions
                                                                                             error:&connectionError];
                                   NSLog(@"%@", [retData objectForKey:@"data"]);
                                   
                                   NSArray *artistsData = [retData objectForKey:@"data"];
                                   NSMutableArray *artists = [NSMutableArray array];
                                   for (NSDictionary *artistDict in artistsData) {
                                       DZRArtist *artist = [[DZRArtist alloc] initWithDictionary:artistDict];
                                       [artists addObject:artist];
                                   }
                                   
                                   completion(artists, nil);
                               }
                           }];

}

@end
