//
//  PhotoSearchRequestCountTests.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2017/01/27.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_flickr_api_demo

class PhotoSearchRequestCountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPhotoSearchRequestCount() {
        
        let count = PhotoSearchRequestCount()
        XCTAssertEqual(count.current(), 1)
        
        for _ in 0..<2 {
            count.incement()
        }
        XCTAssertEqual(count.current(), 3)
        
        count.reset()
        XCTAssertEqual(count.current(), 1)
        
        count.updateTotal(total: 150)
        XCTAssertTrue(count.isMoreRequest())   // 50
        
        count.incement()
        XCTAssertTrue(count.isMoreRequest())   // 100
        
        count.incement()
        XCTAssertFalse(count.isMoreRequest())    //150
    }
}
