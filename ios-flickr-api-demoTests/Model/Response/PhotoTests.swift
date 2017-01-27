//
//  PhotoTests.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2017/01/27.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_flickr_api_demo

class PhotoTests: XCTestCase {
    
    var photosResult: PhotoSearchResult?
    
    override func setUp() {
        super.setUp()
        photosResult = MocPhotoList().feachTestData()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPhoto() {
        
        let photo = self.photosResult?.photos?.photo.first
        
        XCTAssertEqual(photo?.farm, 6)
        XCTAssertEqual(photo?.server, "5696")
        XCTAssertEqual(photo?.id, "32011675501")
        XCTAssertEqual(photo?.secret, "9c9ef7045f")
    }    
}
