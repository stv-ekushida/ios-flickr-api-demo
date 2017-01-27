//
//  PhotoListViewControllerTests.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2017/01/27.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_flickr_api_demo

class PhotoListViewControllerTests: XCTestCase {
    
    var vc: PhotoListViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "PhotoListViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "PhotoListViewController")
        vc = viewController as! PhotoListViewController
        
        _ = vc.view

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCollectionViewAfterViewDidLoadIsNotNil() {
        XCTAssertNotNil(vc.collectionView)
    }
    
    func testTagsTextFieldAfterViewDidLoadNotNil() {
        XCTAssertNotNil(vc.tagsTextField)
    }

    func testSearchButtonAfterViewDidLoadNotNil() {
        XCTAssertNotNil(vc.searchButton)
    }
    
    func testCollectionViewSetDataSource() {
        XCTAssertTrue(vc.collectionView.dataSource is PhotoListCollectionView)
    }
    
    func testCollectionViewSetDelegate() {
        XCTAssertTrue(vc.collectionView.delegate is PhotoListViewController)
    }

    func testTagsTextFieldPlacePholder() {
        XCTAssertEqual(vc.tagsTextField.placeholder, "キーワードを入力してください")
    }
}
