//
//  DZRAlbumTest.m
//  DeezerExerciceTests
//
//  Created by Bin Chen on 18/10/2017.
//  Copyright © 2017 Deezer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DZRAlbum.h"

@interface DZRAlbumTest : XCTestCase

@end

@implementation DZRAlbumTest

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
                           @"id":@"302127",
                           @"title": @"Discovery",
                           @"link": @"https://www.deezer.com/album/302127",
                           @"share": @"http://www.deezer.com/album/302127?utm_source=deezer&utm_content=album-302127&utm_term=0_1508361124&utm_medium=web",
                           @"cover": @"https://api.deezer.com/album/302127/image"
                           };
    DZRAlbum *album = [[DZRAlbum alloc] initWithDictionary:dict];
    
    XCTAssertNotNil(album);
    XCTAssertEqualObjects(album.identifier, @"302127");
    XCTAssertEqualObjects(album.albumTitle, @"Discovery");
    XCTAssertEqualObjects(album.albumCoverUrl, @"https://api.deezer.com/album/302127/image");
}

- (void)testServiceName {
    XCTAssertEqualObjects([DZRAlbum serviceName], @"album");
}

@end
