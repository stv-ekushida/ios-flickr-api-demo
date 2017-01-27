//
//  PhotoListStatusLoadingTests.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2017/01/27.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_flickr_api_demo

class PhotoListStatusLoadingTests: XCTestCase {
    
    var photosResult: PhotoSearchResult?
    
    override func setUp() {
        super.setUp()
        photosResult = MocPhotoList().feachTestData()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPhotoSearchStatusLoading() {
        
        let viewFactory = PhotoListFactory()
        viewFactory.setStatus(status: PhotoListStatus.loading)
        
        XCTAssertEqual(viewFactory.numberOfItemsInSection(photos: []), 1)
        XCTAssertEqual(viewFactory.message(), "読み込み中...")
        
        let size = viewFactory.cellSize()
        let screen = UIScreen.main.bounds
        XCTAssertEqual(size.width, screen.width)
        XCTAssertEqual(size.height, screen.height - 110)
    }
}
