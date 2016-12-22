//
//  PhotoListPage.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListPage {

    fileprivate var pages = 1
    fileprivate var page = 1

    func currentPage() -> Int {
        return page
    }

    func resetPage() {
        page = 1
    }

    func incementPage() {
        page += 1
    }

    func updatePages(pages: Int) {
        self.pages = pages
    }
    
    func isLastpage() -> Bool{
        return pages > page * PhotoSearchParamsBuilder.perPage
    }
}
