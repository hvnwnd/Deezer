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
#import "DZRTrack.h"
#import "DZRParsable.h"

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

//- (void)search:(id<DZRParsable>)object keyWord:(NSString *)keyword
//    completion:(void(^)(NSArray *result, NSError *error))completion
//{
//    [object serviceName];
//}
- (void)requestWithUrl:(NSString *)url completion:(void(^)(NSDictionary *retData, NSError *error))completion
{
    NSURLRequest *APIRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

    [NSURLConnection sendAsynchronousRequest:APIRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError) {
                                   completion(nil, connectionError);
                               } else {
                                   NSError *parseError = nil;
                                   NSDictionary *retData = [NSJSONSerialization JSONObjectWithData:data
                                                                                           options:kNilOptions
                                                                                             error:&parseError];
                                   completion(retData, parseError);
                               }
                           }];

}

- (void)searchArtistWithText:(NSString *)text completion:(void(^)(NSArray<id<DZRParsable>> *result, NSError *error))completion
{
    NSString *escapedString = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"%@/search/artist?q=%@", kDZRBaseURL, escapedString];
    
    [self requestWithUrl:url completion:^(NSDictionary *retData, NSError *error) {
        if (error) {
            completion(nil, error);
        } else {
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

- (void)searchClass:(Class)class withText:(NSString *)text completion:(void(^)(NSArray *result, NSError *error))completion
{
    
}

- (void)fetchFirstAlbumWithArtistId:(NSString *)artistId
                          completion:(void(^)(DZRAlbum *album, NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/artist/%@/albums?limit=1", kDZRBaseURL, artistId];
    [self requestWithUrl:url completion:^(NSDictionary *retData, NSError *error) {
        if (error) {
            completion(nil, error);
        } else {
            DZRAlbum *album = [[DZRAlbum alloc] initWithDictionary:[retData[@"data"] firstObject]];
            completion(album, nil);
        }
    }];
}

- (void)fetchAlbumTracksWithAlbumId:(NSString *)albumId
                         completion:(void(^)(NSArray *trackList, NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/album/%@", kDZRBaseURL, albumId];
    [self requestWithUrl:url completion:^(NSDictionary *retData, NSError *error) {
        if (error) {
            completion(nil, error);
        } else {
            NSArray *tracksData = retData[@"tracks"][@"data"];
            NSMutableArray *tracks = [NSMutableArray array];
            for (NSDictionary *trackDict in tracksData) {
                DZRTrack *track = [[DZRTrack alloc] initWithDictionary:trackDict];
                [tracks addObject:track];
            }
            completion(tracks, nil);
        }
    }];
}

@end
