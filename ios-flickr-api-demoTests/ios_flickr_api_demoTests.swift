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

//テストデータ (100件）
//{
//    "photos": {
//        "page": 1,
//        "pages": 4168,
//        "perpage": 100,
//        "photo": [
//            {
//                "farm": 6,
//                "id": "32011675501",
//                "isfamily": 0,
//                "isfriend": 0,
//                "ispublic": 1,
//                "owner": "136944338@N05",
//                "secret": "9c9ef7045f",
//                "server": "5696",
//                "title": "Miracle Niki - Change clothing CODE RPG - Android & iOS apps - Free"
//            },
//            {
//                "farm": 1,
//                "id": "31318948623",
//                "isfamily": 0,
//                "isfriend": 0,
//                "ispublic": 1,
//                "owner": "96227749@N06",
//                "secret": "e7cac8dc3c",
//                "server": "624",
//                "title": "New photo added to "Польша""
//            },
//        ],
//        "total": "416709"
//    },
//    "stat": "ok"
//}

class ios_flickr_api_demoTests: XCTestCase {

    var photosResult: PhotoSearchResult?
    
    override func setUp() {
        super.setUp()
        setupTestData()
    }
    
    override func tearDown() {
        super.tearDown()
        self.photosResult = nil
    }

    func testPhoto() {

        let photo = self.photosResult?.photos?.photo.first
        
        XCTAssertEqual(photo?.farm, 6)
        XCTAssertEqual(photo?.server, "5696")
        XCTAssertEqual(photo?.id, "32011675501")
        XCTAssertEqual(photo?.secret, "9c9ef7045f")
    }
    
    func testPhotos() {

        let photos = self.photosResult?.photos

        XCTAssertEqual(photos?.page, 1)
        XCTAssertEqual(photos?.pages, 4168)
        XCTAssertEqual(photos?.perpage, 100)
        XCTAssertEqual(photos?.photo.count, 100)
        XCTAssertNotNil(photos?.photo.first)
        XCTAssertNotNil(photos?.photo.last)
    }

    func testPhotosResult() {

        let photosResult = self.photosResult

        XCTAssertEqual(photosResult?.stat, "ok")
        XCTAssertNotNil(photosResult?.photos)
    }
    
    func testPhotoImageURLBuilder() {
        
        let photo = self.photosResult?.photos?.photo.first
            
        XCTAssertEqual(PhotoImageURLBuilder.create(photo: photo!),
                       "https://farm6.staticflickr.com/5696/32011675501_9c9ef7045f.jpg")
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

        let viewFactory = PhotoListFactory()
        viewFactory.setStatus(status: PhotoListStatus.none)
        XCTAssertEqual(viewFactory.numberOfItemsInSection(photos: []), 1)
    
        XCTAssertEqual(viewFactory.message(), "キーワードを入力し、写真を検索してみましょう！")

        let size = viewFactory.cellSize()
        let screen = UIScreen.main.bounds
        XCTAssertEqual(size.width, screen.width)
        XCTAssertEqual(size.height, screen.height - 110)
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

    func testPhotoSearchStatusOffline() {

        let viewFactory = PhotoListFactory()
        viewFactory.setStatus(status: PhotoListStatus.offline)

        XCTAssertEqual(viewFactory.numberOfItemsInSection(photos: []), 1)
        XCTAssertEqual(viewFactory.message(), "ネットワーク環境の良い環境で再度お試しください。")

        let size = viewFactory.cellSize()
        let screen = UIScreen.main.bounds
        XCTAssertEqual(size.width, screen.width)
        XCTAssertEqual(size.height, screen.height - 110)
    }

    //MARK:- private Method
    private func setupTestData() {

        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "flickr", ofType: "json")
        if let path = path {

            let fileHandle = FileHandle(forReadingAtPath: path)
            let jsonData = fileHandle?.readDataToEndOfFile()

            if let jsonData = jsonData {

                let json = String(data: jsonData,
                                  encoding: String.Encoding.utf8)

                if let json = json {

                    if let searchResult = Mapper<PhotoSearchResult>().map(JSONString: json) {
                        self.photosResult = searchResult
                    }
                }
            }
        }
    }
}
