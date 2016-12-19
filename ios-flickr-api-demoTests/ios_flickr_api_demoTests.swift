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
        
        if let photo = Mapper<PhotoSearchResult>().map(JSONObject: json) {
            XCTAssertEqual(photo.photos?.page, 100)
            XCTAssertEqual(photo.photos?.pages, 1000)
            XCTAssertEqual(photo.photos?.perpage, 100)
            XCTAssertEqual(photo.photos?.photo.first?.farm, 123)
            XCTAssertEqual(photo.photos?.photo.first?.server, "123abc")
            XCTAssertEqual(photo.photos?.photo.first?.id, "456def")
            XCTAssertEqual(photo.photos?.photo.first?.secret, "789ghi")
        }
    }
    
    func testPhotos() {
        
        let json = try! JSONSerialization.data(withJSONObject: photosDic,
                                               options: [])
        
        if let photo = Mapper<Photos>().map(JSONObject: json) {
            XCTAssertEqual(photo.page, 1)
            XCTAssertEqual(photo.pages, 100)
            XCTAssertEqual(photo.perpage, 50)
            XCTAssertEqual(photo.photo.first?.farm, 111)
            XCTAssertEqual(photo.photo.first?.server, "abc")
            XCTAssertEqual(photo.photo.first?.id, "def")
            XCTAssertEqual(photo.photo.first?.secret, "ghi")
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
    
    func testPhotoSearchStatus() {
        
        let typeNone = PhotoSearchStatus.none.type()
        XCTAssertTrue(typeNone is PhotoListStatusNone)
        
        let json = try! JSONSerialization.data(withJSONObject: photosResultDic,
                                               options: [])
        
        if let photo = Mapper<PhotoSearchResult>().map(JSONObject: json) {
            let typeNormal = PhotoSearchStatus.normal(photo).type()
            XCTAssertTrue(typeNormal is PhotoListStatusNormal)
        }
        
        let typeNoData = PhotoSearchStatus.noData.type()
        XCTAssertTrue(typeNoData is PhotoListStatusNoData)
        
        let typeOffline = PhotoSearchStatus.offline.type()
        XCTAssertTrue(typeOffline is PhotoListStatusOffline)
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
    
    func testPhotoListStatusNormal() {
        
        let status = PhotoListStatusNormal()
        
        let json = try! JSONSerialization.data(withJSONObject: photoDic,
                                               options: [])
        
        if let photo = Mapper<Photo>().map(JSONObject: json) {
            XCTAssertEqual(status.numberOfItemsInSection(photos: [photo]), 1)
        }
        
        let size = status.cellSize(topOf: PhotoListViewController())
        XCTAssertEqual(size.height, (UIScreen.main.bounds.height - 110) / 5)
        XCTAssertEqual(size.width, UIScreen.main.bounds.width / 3)

    }
    
    func testPhotoListStatusCommon() {
        
        let status = PhotoListStatusCommon()
        XCTAssertEqual(status.numberOfItemsInSection(photos: []), 1)
        
        let size = status.cellSize(topOf: PhotoListViewController())
        XCTAssertEqual(size.height, UIScreen.main.bounds.height - 110)
        XCTAssertEqual(size.width, UIScreen.main.bounds.width)
    }
    
    func testPhotoListStatusNoData() {
        
        let status = PhotoListStatusNoData()
        XCTAssertEqual(status.numberOfItemsInSection(photos: []), 1)
        XCTAssertEqual(status.message, "該当する写真がありません。\n検索ワードを変更してお試しください。")
        
        let size = status.cellSize(topOf: PhotoListViewController())
        XCTAssertEqual(size.height, UIScreen.main.bounds.height - 110)
        XCTAssertEqual(size.width, UIScreen.main.bounds.width)
    }

    func testPhotoListStatusNone() {
        
        let status = PhotoListStatusNone()
        XCTAssertEqual(status.numberOfItemsInSection(photos: []), 1)
        XCTAssertEqual(status.message, "キーワードを入力し、写真を検索してみましょう！")
        
        let size = status.cellSize(topOf: PhotoListViewController())
        XCTAssertEqual(size.height, UIScreen.main.bounds.height - 110)
        XCTAssertEqual(size.width, UIScreen.main.bounds.width)
    }
    
    func testPhotoListStatusOffline() {
        
        let status = PhotoListStatusOffline()
        XCTAssertEqual(status.numberOfItemsInSection(photos: []), 1)
        XCTAssertEqual(status.message, "ネットワーク環境の良い環境で再度お試しください。")
        
        let size = status.cellSize(topOf: PhotoListViewController())
        XCTAssertEqual(size.height, UIScreen.main.bounds.height - 110)
        XCTAssertEqual(size.width, UIScreen.main.bounds.width)
    }
}
