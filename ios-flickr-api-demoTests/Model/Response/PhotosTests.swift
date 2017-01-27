//
//  PhotosTests.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2017/01/27.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_flickr_api_demo

class PhotosTests: XCTestCase {
    
    var photosResult: PhotoSearchResult?
    
    override func setUp() {
        super.setUp()
        photosResult = MocPhotoList().feachTestData()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPhotos() {
        
        let photos = self.photosResult?.photos
        
        XCTAssertEqual(photos?.page, 1)
        XCTAssertEqual(photos?.pages, 4168)
        XCTAssertEqual(photos?.perpage, 100)
        XCTAssertEqual(photos?.photo.count, 100)
        XCTAssertNotNil(photos?.photo.first)
        XCTAssertNotNil(photos?.photo.last)
    }
}
