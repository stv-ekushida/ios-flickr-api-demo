//
//  PhotoSearchParser.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit
import SwiftyJSON

final class PhotoSearchParser {

    static func parse(json: JSON) -> PhotoSearchResult{

        var result = PhotoSearchResult()
        result.page = json["page"].intValue
        result.pages = json["pages"].intValue
        result.perpage = json["perpage"].intValue

        for photo in json["photo"].arrayValue {

            var item = Photo()
            item.id = photo["id"].stringValue
            item.farm = photo["farm"].intValue
            item.secret = photo["secret"].stringValue
            item.server = photo["server"].stringValue
            result.photo.append(item)
        }
        return result
    }
}
