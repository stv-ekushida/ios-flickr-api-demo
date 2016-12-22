//
//  PhotoSearchRequestCount.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoSearchRequestCount {

    private var requestCount = 1
    private var totalCount = 1

    func current() -> Int {
        return requestCount
    }

    func reset() {
        requestCount = 1
    }

    func incement() {
        requestCount += 1
    }

    func updateTotal(total: Int) {
        self.totalCount = total
    }
    
    func moreRequest() -> Bool{
        print(totalCount)
        print(requestCount * PhotoSearchParamsBuilder.perPage)

        return totalCount > requestCount * PhotoSearchParamsBuilder.perPage
    }
}
