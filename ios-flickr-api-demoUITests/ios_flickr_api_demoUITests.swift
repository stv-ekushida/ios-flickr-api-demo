//
//  ios_flickr_api_demoUITests.swift
//  ios-flickr-api-demoUITests
//
//  Created by Eiji Kushida on 2017/01/11.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import XCTest

class ios_flickr_api_demoUITests: XCTestCase {

    //accessibilityID
    let aIDTagsTextField = "tagsTextField"
    let aIDSearchButton = "searchButton"
    let aIDMessageTextView = "messageTextView"

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    //初期表示の確認
    func testNoneSearch() {

        XCTAssertEqual(app.textViews[aIDMessageTextView].value as! String,
                       "キーワードを入力し、写真を検索してみましょう！")
    }

    //読み込み中の表示確認
    func testLoadingSearch() {

        self.inputTagsText(tags: "東京オリンピック")
        self.tapSearch()

//        XCTAssertEqual(app.textViews[aIDMessageTextView].value as! String,
//                       "読み込み中...")
    }

    //データが無いときの表示確認
    func testNoDataSearch() {

        self.inputTagsText(tags: "ああ東京あああ")
        self.tapSearch()
        sleep(1)

        XCTAssertEqual(app.textViews[aIDMessageTextView].value as! String,
                       "該当する写真がありません。\n検索ワードを変更してお試しください。")
    }

    //MARK:- private method for UITest
    private func inputTagsText(tags: String) {

        let tagsTextField = app.textFields[aIDTagsTextField]
        tagsTextField.tap()
        tagsTextField.typeText(tags)
    }

    private func tapSearch() {

        let searchButton = app.buttons[aIDSearchButton]
        searchButton.tap()
    }
}
