//
//  PhotoListStatusNormalTests.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2017/01/27.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_flickr_api_demo

class PhotoListStatusNormalTests: XCTestCase {
    
    var photosResult: PhotoSearchResult?
    
    override func setUp() {
        super.setUp()
        photosResult = MocPhotoList().feachTestData()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPhotoSearchStatusNormal() {
        
        if let photosResult = self.photosResult,
            let photo = photosResult.photos?.photo {
            
            let viewFactory = PhotoListFactory()
            viewFactory.setStatus(status: PhotoListStatus.normal(photosResult))
            
            XCTAssertEqual(viewFactory.numberOfItemsInSection(photos: photo), 100)
            
            let size = viewFactory.cellSize()
            let screen = UIScreen.main.bounds
            XCTAssertEqual(size.width, screen.width / 3)
            XCTAssertEqual(size.height, (screen.height - 110) / 5)
        }
    }
}
