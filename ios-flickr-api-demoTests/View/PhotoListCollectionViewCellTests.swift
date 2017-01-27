//
//  PhotoListCollectionViewCellTests.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2017/01/27.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest
@testable import ios_flickr_api_demo

class PhotoListCollectionViewCellTests: XCTestCase {
    
    var collectionView: UICollectionView!
    let dataSource = FakeDataSource()
    var cell: PhotoListCollectionViewCell!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "PhotoListViewController", bundle: nil)
        let controller = storyboard
            .instantiateViewController(
                withIdentifier: "PhotoListViewController")
            as! PhotoListViewController
        
        _ = controller.view
        
        collectionView = controller.collectionView
        collectionView?.dataSource = dataSource
        
        cell = collectionView?.dequeueReusableCell(
            withReuseIdentifier: "PhotoListCollectionViewCell",
            for: IndexPath(row: 0, section: 0)) as! PhotoListCollectionViewCell
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasPhotoImageView() {
        XCTAssertNotNil(cell.photoImageView)
    }
    
    func testHasCollectionViewCellIdentifier() {
        XCTAssertEqual(PhotoListCollectionViewCell.identifier, "PhotoListCollectionViewCell")
    }
    
    func testHasCollectionViewCellPhoto() {
        
        let photosResult = MocPhotoList().feachTestData()
        let photo = photosResult.photos?.photo.first
        
        cell.photo = photo
        XCTAssertNotNil(cell.photo)
    }
}

extension PhotoListCollectionViewCellTests {
    
    class FakeDataSource: NSObject, UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return UICollectionViewCell()
        }
    }
}
