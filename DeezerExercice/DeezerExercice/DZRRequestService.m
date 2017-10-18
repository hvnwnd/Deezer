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
#import "NSDictionary+DZRParsable.h"

NSString *const kDZRBaseURL = @"https://api.deezer.com/";

@implementation DZRRequestService

- (void)searchArtistWithText:(NSString *)text
                  completion:(void(^)(NSArray<DZRArtist *> *result, NSError *error))completion;
{
    [self searchClass:[DZRArtist class] withText:text completion:completion];
}

- (void)fetchFirstAlbumWithArtistId:(NSString *)artistId
                          completion:(void(^)(NSArray<DZRAlbum *> *albums, NSError *error))completion
{
    [self fetchDetailWithParentClass:[DZRArtist class] childClass:[DZRAlbum class] withIdentifier:artistId limit:1 completion:completion];
}

- (void)fetchAlbumTracksWithAlbumId:(NSString *)albumId
                         completion:(void(^)(NSArray<DZRTrack *> *tracks, NSError *error))completion
{
    [self fetchDetailWithParentClass:[DZRAlbum class] childClass:[DZRTrack class] withIdentifier:albumId limit:NSNotFound completion:completion];
}

#pragma mark - Private
- (void)requestWithUrl:(NSString *)url
            completion:(void(^)(NSDictionary *retData, NSError *error))completion
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

- (void)searchClass:(Class<DZRParsable>)class
           withText:(NSString *)text
         completion:(void(^)(NSArray<id<DZRParsable>> *result, NSError *error))completion
{
    NSString *serviceName = [class serviceName];
    NSString *escapedString = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"%@/search/%@?q=%@", kDZRBaseURL, serviceName, escapedString];
    
    [self requestWithUrl:url completion:^(NSDictionary *retData, NSError *error) {
        if (error) {
            completion(nil, error);
        } else {
            NSArray *result = [retData parsedArrayWithClass:class];
            completion(result, nil);
        }
    }];
}

- (void)fetchDetailWithParentClass:(Class<DZRParsable>)class
               childClass:(Class<DZRParsable>)childCls
          withIdentifier:(NSString *)identifier
                   limit:(NSUInteger)limit
              completion:(void(^)(NSArray *resultList, NSError *error))completion
{
    NSString *serviceName = [class serviceName];
    NSString *subServiceName = [childCls serviceName];
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@/%@/%@s", kDZRBaseURL, serviceName, identifier, subServiceName];
    if (limit != NSNotFound){
        [url appendFormat:@"?limit=%lu", (unsigned long)limit];
    }
    
    [self requestWithUrl:url completion:^(NSDictionary *retData, NSError *error) {
        if (error) {
            completion(nil, error);
        } else {
            NSArray *result = [retData parsedArrayWithClass:childCls];
            completion(result, nil);
        }
    }];
}

@end
