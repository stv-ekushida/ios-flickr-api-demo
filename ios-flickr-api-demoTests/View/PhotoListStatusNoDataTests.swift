//
//  PhotoListStatusNoDataTests.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2017/01/27.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_flickr_api_demo

class PhotoListStatusNoDataTests: XCTestCase {
    
    var photosResult: PhotoSearchResult?
    
    override func setUp() {
        super.setUp()
        photosResult = MocPhotoList().feachTestData()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPhotoSearchStatusNoData() {
        
        let viewFactory = PhotoListFactory()
        viewFactory.setStatus(status: PhotoListStatus.noData)
        
        XCTAssertEqual(viewFactory.numberOfItemsInSection(photos: []), 1)
        XCTAssertEqual(viewFactory.message(), "該当する写真がありません。\n検索ワードを変更してお試しください。")
        
        let size = viewFactory.cellSize()
        let screen = UIScreen.main.bounds
        XCTAssertEqual(size.width, screen.width)
        XCTAssertEqual(size.height, screen.height - 110)
    }
}
