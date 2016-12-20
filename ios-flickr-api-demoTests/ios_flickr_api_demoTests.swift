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
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPhoto() {
        
        let json = try! JSONSerialization.data(withJSONObject: photoDic,
                                               options: [])
        
        if let photo = Mapper<Photo>().map(JSONObject: json) {
            XCTAssertEqual(photo.farm, 100)
            XCTAssertEqual(photo.server, "22222")
            XCTAssertEqual(photo.id, "33333")
            XCTAssertEqual(photo.secret, "44444")
        }
    }
    
    func testPhotosResult() {
        
        let json = try! JSONSerialization.data(withJSONObject: photosResultDic,
                                               options: [])
        
        if let photosResult = Mapper<PhotoSearchResult>().map(JSONObject: json) {
            XCTAssertEqual(photosResult.photos?.page, 100)
            XCTAssertEqual(photosResult.photos?.pages, 1000)
            XCTAssertEqual(photosResult.photos?.perpage, 100)
            XCTAssertEqual(photosResult.photos?.photo.first?.farm, 123)
            XCTAssertEqual(photosResult.photos?.photo.first?.server, "123abc")
            XCTAssertEqual(photosResult.photos?.photo.first?.id, "456def")
            XCTAssertEqual(photosResult.photos?.photo.first?.secret, "789ghi")
        }
    }
    
    func testPhotos() {
        
        let json = try! JSONSerialization.data(withJSONObject: photosDic,
                                               options: [])
        
        if let photos = Mapper<Photos>().map(JSONObject: json) {
            XCTAssertEqual(photos.page, 1)
            XCTAssertEqual(photos.pages, 100)
            XCTAssertEqual(photos.perpage, 50)
            XCTAssertEqual(photos.photo.first?.farm, 111)
            XCTAssertEqual(photos.photo.first?.server, "abc")
            XCTAssertEqual(photos.photo.first?.id, "def")
            XCTAssertEqual(photos.photo.first?.secret, "ghi")
        }
    }
    
    func testPhotoImageURLBuilder() {
        
        let json = try! JSONSerialization.data(withJSONObject: photoDic,
                                               options: [])
        
        if let photo = Mapper<Photo>().map(JSONObject: json) {
            
            XCTAssertEqual(PhotoImageURLBuilder.create(photo: photo),
                           "https://farm100.staticflickr.com/22222/33333_44444.jpg")
        }
    }
    
    func testPhotoListPage() {
        
        let page = PhotoListPage()
        XCTAssertEqual(page.currentPage(), 1)
        
        page.incementPage()
        page.incementPage()
        XCTAssertEqual(page.currentPage(), 3)
        
        page.resetPage()
        XCTAssertEqual(page.currentPage(), 1)
        
        page.updatePages(pages: 100)
        XCTAssertEqual(page.total(), 100)
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

        XCTAssertEqual(status.numberOfItemsInSection(), 1)
        XCTAssertEqual(status.message(), "キーワードを入力し、写真を検索してみましょう！")

        let size = status.cellCeze()
        let screen = UIScreen.main.bounds
        XCTAssertEqual(size.width, screen.width)
        XCTAssertEqual(size.height, screen.height - 110)
    }

    func testPhotoSearchStatusLoading() {

        let status = PhotoSearchStatus.loading

        XCTAssertEqual(status.numberOfItemsInSection(), 1)
        XCTAssertEqual(status.message(), "読み込み中...")

        let size = status.cellCeze()
        let screen = UIScreen.main.bounds
        XCTAssertEqual(size.width, screen.width)
        XCTAssertEqual(size.height, screen.height - 110)
    }

    func testPhotoSearchStatusNormal() {

        let json = try! JSONSerialization.data(withJSONObject: photosResultDic,
                                               options: [])

        if let photo = Mapper<PhotoSearchResult>().map(JSONObject: json) {

            let status = PhotoSearchStatus.normal(photo)
            XCTAssertEqual(status.numberOfItemsInSection(), 1)

            let size = status.cellCeze()
            let screen = UIScreen.main.bounds
            XCTAssertEqual(size.width, screen.width)
            XCTAssertEqual(size.height, screen.height - 110)
       }
    }

    func testPhotoSearchStatusNoData() {

        let status = PhotoSearchStatus.noData

        XCTAssertEqual(status.numberOfItemsInSection(), 1)
        XCTAssertEqual(status.message(), "該当する写真がありません。\n検索ワードを変更してお試しください。")

        let size = status.cellCeze()
        let screen = UIScreen.main.bounds
        XCTAssertEqual(size.width, screen.width)
        XCTAssertEqual(size.height, screen.height - 110)
    }

    func testPhotoSearchStatusOffline() {

        let status = PhotoSearchStatus.offline

        XCTAssertEqual(status.numberOfItemsInSection(), 1)
        XCTAssertEqual(status.message(), "ネットワーク環境の良い環境で再度お試しください。")

        let size = status.cellCeze()
        let screen = UIScreen.main.bounds
        XCTAssertEqual(size.width, screen.width)
        XCTAssertEqual(size.height, screen.height - 110)
    }
}
