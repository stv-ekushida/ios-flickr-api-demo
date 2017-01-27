//
//  PhotoImageURLBuilderTests.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2017/01/27.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_flickr_api_demo

class PhotoImageURLBuilderTests: XCTestCase {
    
    var photosResult: PhotoSearchResult?
    
    override func setUp() {
        super.setUp()
        photosResult = MocPhotoList().feachTestData()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPhotoImageURLBuilder() {
        
        let photo = self.photosResult?.photos?.photo.first
        
        XCTAssertEqual(PhotoImageURLBuilder.create(photo: photo!),
                       "https://farm6.staticflickr.com/5696/32011675501_9c9ef7045f.jpg")
    }
}
