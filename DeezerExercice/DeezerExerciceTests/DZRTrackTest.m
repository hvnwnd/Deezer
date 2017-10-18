//
//  DZRTrackTest.m
//  DeezerExerciceTests
//
//  Created by Bin Chen on 18/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DZRTrack.h"

@interface DZRTrackTest : XCTestCase

@end

@implementation DZRTrackTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitsWithDictionary {
    NSDictionary *dict = @{
                           @"id": @"3135556",
                           @"readable": @(YES),
                           @"title": @"Harder Better Faster Stronger",
                           @"title_short": @"Harder Better Faster Stronger",
                           @"title_version": @"",
                           @"isrc": @"GBDUW0000059",
                           @"link": @"https://www.deezer.com/track/3135556",
                           @"preview": @"https://e-cdns-preview-5.dzcdn.net/stream/51afcde9f56a132096c0496cc95eb24b-4.mp3"
                           };

    
    DZRTrack *track = [[DZRTrack alloc] initWithDictionary:dict];
    XCTAssertNotNil(track);
    XCTAssertEqualObjects(track.identifier, @"3135556");
    XCTAssertEqualObjects(track.trackTitle, @"Harder Better Faster Stronger");
    XCTAssertEqualObjects(track.trackUrl, @"https://e-cdns-preview-5.dzcdn.net/stream/51afcde9f56a132096c0496cc95eb24b-4.mp3");
}

- (void)testServiceName {
    XCTAssertEqualObjects([DZRTrack serviceName], @"track");
}

@end
