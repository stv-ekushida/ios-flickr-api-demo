//
//  ios_flickr_api_demoTests.swift
//  ios-flickr-api-demoTests
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import ios_flickr_api_demo

class ios_flickr_api_demoTests: XCTestCase {
    
    let photoDic: [String: Any] = [
        "photo": [
            "farm": 100,
            "server": "22222",
            "id": "33333",
            "secret": "44444"
        ]
    ]
    
    let photosDic: [String: Any] = [
        "page": 1,
        "pages" : 100,
        "perpage" : 50,
        "photo": [
            "farm": 111,
            "server": "abc",
            "id": "def",
            "secret": "ghi"
        ]
    ]
    
    let photosResultDic: [String: Any] = [
        
        "stat": "ok",
        "photos": [
            "page": 100,
            "pages" : 1000,
            "perpage" : 100,
            "photo": [
                "farm": 123,
                "server": "123abc",
                "id": "456def",
                "secret": "789ghi"
            ]
        ]
    ]
    
    var photo: Photo?
    var photos: Photos?
    var photosResult: PhotoSearchResult?
    
    override func setUp() {
        super.setUp()
        
        let jsonPhoto = try! JSONSerialization.data(withJSONObject: photoDic,
                                               options: [])
        
        if let photo = Mapper<Photo>().map(JSONObject: jsonPhoto) {
            self.photo = photo
        }
        
        let jsonPhotos = try! JSONSerialization.data(withJSONObject: photosDic,
                                               options: [])
        
        if let photos = Mapper<Photos>().map(JSONObject: jsonPhotos) {
            self.photos = photos
        }
        
        let jsonPhotosResult = try! JSONSerialization.data(withJSONObject: photosResultDic,
                                               options: [])
        
        if let photosResult = Mapper<PhotoSearchResult>().map(JSONObject: jsonPhotosResult) {
            self.photosResult = photosResult
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPhoto() {
        
        if let photo = self.photo {
            XCTAssertEqual(photo.farm, 100)
            XCTAssertEqual(photo.server, "22222")
            XCTAssertEqual(photo.id, "33333")
            XCTAssertEqual(photo.secret, "44444")
        }
    }
    
    func testPhotos() {
        
        if let photos = self.photos {
            XCTAssertEqual(photos.page, 1)
            XCTAssertEqual(photos.pages, 100)
            XCTAssertEqual(photos.perpage, 50)
            XCTAssertEqual(photos.photo.first?.farm, 111)
            XCTAssertEqual(photos.photo.first?.server, "abc")
            XCTAssertEqual(photos.photo.first?.id, "def")
            XCTAssertEqual(photos.photo.first?.secret, "ghi")
        }
    }

    
    func testPhotosResult() {
        
        if let photosResult = self.photosResult {
            XCTAssertEqual(photosResult.photos?.page, 100)
            XCTAssertEqual(photosResult.photos?.pages, 1000)
            XCTAssertEqual(photosResult.photos?.perpage, 100)
            XCTAssertEqual(photosResult.photos?.photo.first?.farm, 123)
            XCTAssertEqual(photosResult.photos?.photo.first?.server, "123abc")
            XCTAssertEqual(photosResult.photos?.photo.first?.id, "456def")
            XCTAssertEqual(photosResult.photos?.photo.first?.secret, "789ghi")
        }
    }
    
    func testPhotoImageURLBuilder() {
        
        if let photo = self.photo {
            
            XCTAssertEqual(PhotoImageURLBuilder.create(photo: photo),
                           "https://farm100.staticflickr.com/22222/33333_44444.jpg")
        }
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
        XCTAssertTrue(count.moreRequest())   // 50
        
        count.incement()
        XCTAssertTrue(count.moreRequest())   // 100

        count.incement()
        XCTAssertFalse(count.moreRequest())    //150
    }
    
    func testPhotoSearchParamsBuilder() {
        
        let params = PhotoSearchParamsBuilder.create(tags: "あいうえお",
                                                     page: 1) as! [String: String]
        
        XCTAssertEqual(params["tags"], "あいうえお")
        XCTAssertEqual(params["method"], "flickr.photos.search")
        XCTAssertEqual(params["page"], "1")
        XCTAssertEqual(params["per_page"], "50")
    }
    
    func testPhotoSearchAPI() {
        XCTAssertFalse(PhotoSearchAPI().waiting())
    }
    
    func testFlickrBaseParamBuilder() {
        
        let params = FlickrBaseParamsBuilder.create() as! [String: String]
        XCTAssertEqual(params["method"], "flickr.photos.search")
        XCTAssertEqual(params["nojsoncallback"], "1")
        XCTAssertEqual(params["format"], "json")
    }

    func testPhotoSearchStatusNone() {

        let status = PhotoSearchStatus.none
        XCTAssertEqual(status.numberOfItemsInSection(photos: []), 1)
    
        XCTAssertEqual(status.message(), "キーワードを入力し、写真を検索してみましょう！")

        let size = status.cellCeze()
        let screen = UIScreen.main.bounds
        XCTAssertEqual(size.width, screen.width)
        XCTAssertEqual(size.height, screen.height - 110)
    }

    func testPhotoSearchStatusLoading() {

        let status = PhotoSearchStatus.loading
        XCTAssertEqual(status.numberOfItemsInSection(photos: []), 1)
        XCTAssertEqual(status.message(), "読み込み中...")

        let size = status.cellCeze()
        let screen = UIScreen.main.bounds
        XCTAssertEqual(size.width, screen.width)
        XCTAssertEqual(size.height, screen.height - 110)
    }

    func testPhotoSearchStatusNormal() {

        if let photosResult = self.photosResult {

            let status = PhotoSearchStatus.normal(photosResult)
            XCTAssertEqual(status.numberOfItemsInSection(photos: []), 1)

            let size = status.cellCeze()
            let screen = UIScreen.main.bounds
            XCTAssertEqual(size.width, screen.width)
            XCTAssertEqual(size.height, screen.height - 110)
       }
    }

    func testPhotoSearchStatusNoData() {

        let status = PhotoSearchStatus.noData

        XCTAssertEqual(status.numberOfItemsInSection(photos: []), 1)
        XCTAssertEqual(status.message(), "該当する写真がありません。\n検索ワードを変更してお試しください。")

        let size = status.cellCeze()
        let screen = UIScreen.main.bounds
        XCTAssertEqual(size.width, screen.width)
        XCTAssertEqual(size.height, screen.height - 110)
    }

    func testPhotoSearchStatusOffline() {

        let status = PhotoSearchStatus.offline

        XCTAssertEqual(status.numberOfItemsInSection(photos: []), 1)
        XCTAssertEqual(status.message(), "ネットワーク環境の良い環境で再度お試しください。")

        let size = status.cellCeze()
        let screen = UIScreen.main.bounds
        XCTAssertEqual(size.width, screen.width)
        XCTAssertEqual(size.height, screen.height - 110)
    }
}
