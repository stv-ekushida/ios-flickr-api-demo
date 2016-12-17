//
//  PhotoSearchResult.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit
import SwiftyJSON

struct PhotoSearchResult {
    var page = 0
    var pages = 0
    var perpage = 0
    var photo: [Photo] = []
}
