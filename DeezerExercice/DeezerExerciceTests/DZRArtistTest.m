//
//  DZRArtistTest.m
//  DeezerExercice
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "DZRArtist.h"

@interface DZRArtistTest : XCTestCase

@end

@implementation DZRArtistTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitsWithDictionary {
    /*
     {
     id = 1033;
     link = "http://www.deezer.com/artist/1033";
     name = "Alain Souchon";
     "nb_album" = 49;
     "nb_fan" = 60625;
     picture = "http://api.deezer.com/artist/1033/image";
     radio = 1;
     tracklist = "http://api.deezer.com/artist/1033/top?limit=50";
     type = artist;
     }
     */
    NSDictionary *dictionary = @{ @"id":@"1033",
                                     @"link":@"http://www.deezer.com/artist/1033",
                                     @"name":@"Alain Souchon",
                                     @"nb_albums":@"49",
                                     @"nb_fan": @"60625",
                                     @"picture":@"http://api.deezer.com/artist/1033/image",
                                     @"radio":@"1",
                                     @"tracklist":@"http://api.deezer.com/artist/1033/top?limit=50",
                                     @"type":@"artist",
                                     };
    DZRArtist *artist = [[DZRArtist alloc] initWithDictionary:dictionary];
    
    XCTAssertNotNil(artist);
    XCTAssertEqualObjects(artist.identifier, @"1033");
    XCTAssertEqualObjects(artist.artistName, @"Alain Souchon");
    XCTAssertEqualObjects(artist.artistPictureUrl, @"http://api.deezer.com/artist/1033/image");
}

- (void)testServiceName {
    XCTAssertEqualObjects([DZRArtist serviceName], @"artist");
}

@end
