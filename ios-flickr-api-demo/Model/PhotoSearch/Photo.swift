//
//  Photo.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import Foundation
import ObjectMapper

struct Photo: Mappable {
    var farm = 0
    var server = ""
    var id = ""
    var secret = ""

    init?(map: Map){}

    mutating func mapping(map: Map) {
        farm    <- map["farm"]
        server  <- map["server"]
        id      <- map["id"]
        secret  <- map["secret"]
    }
}
