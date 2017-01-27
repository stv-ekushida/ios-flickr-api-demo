//
//  PhotoSearchResultTests.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2017/01/27.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_flickr_api_demo

class PhotoSearchResultTests: XCTestCase {
    
    var photosResult: PhotoSearchResult?
    
    override func setUp() {
        super.setUp()
        photosResult = MocPhotoList().feachTestData()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPhotosResult() {
        
        let photosResult = self.photosResult
        
        XCTAssertEqual(photosResult?.stat, "ok")
        XCTAssertNotNil(photosResult?.photos)
    }
}
