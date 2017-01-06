//
//  PhotoSearchResult.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit
import ObjectMapper

struct PhotoSearchResult: Mappable {

    var stat = ""
    var photos: Photos?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        stat <- map["stat"]
        photos <- map["photos"]
    }
}
