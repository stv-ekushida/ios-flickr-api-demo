//
//  Photos.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2016/12/18.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import Foundation
import ObjectMapper

struct Photos: Mappable {

    var page = 0
    var pages = 0
    var perpage = 0
    var photo: [Photo] = []

    init?(map: Map){}

    mutating func mapping(map: Map) {
        page    <- map["page"]
        pages   <- map["pages"]
        perpage <- map["perpage"]
        photo   <- map["photo"]
    }
}
