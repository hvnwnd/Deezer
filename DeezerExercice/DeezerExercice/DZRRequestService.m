//
//  DZRRequestService.m
//  DeezerExercice
//
//  Created by CHEN Bin on 16/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import "DZRRequestService.h"
#import "DZRArtist.h"
#import "DZRAlbum.h"

NSString *const kDZRBaseURL = @"https://api.deezer.com/";

@interface DZRRequestService()

@property (nonatomic) NSOperationQueue *requestQueue;

@end
@implementation DZRRequestService

- (instancetype)init
{
    self = [super init];
    if (self) {
        _requestQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

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

- (void)searchFirstAlbumWithArtistId:(NSString *)artistId
                          completion:(void(^)(DZRAlbum *album, NSError *error))completion
{
    NSString *urlRequest = [NSString stringWithFormat:@"%@/artist/%@/albums?limit=1", kDZRBaseURL, artistId];
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
                                   NSLog(@"%@", [retData[@"data"] firstObject]);
                                   DZRAlbum *album = [[DZRAlbum alloc] initWithDictionary:[retData[@"data"] firstObject]];
                                   completion(album, nil);
                               }
                           }];
}

- (void)searchAlbumMusicWithArtistId:(NSString *)albumId
                          completion:(void(^)(NSArray *songList, NSError *error))completion
{
    
    //http://api.deezer.com/album/302127
    NSString *urlRequest = [NSString stringWithFormat:@"%@/album/%@", kDZRBaseURL, albumId];

    NSURLRequest *APIRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:albumId]];
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
