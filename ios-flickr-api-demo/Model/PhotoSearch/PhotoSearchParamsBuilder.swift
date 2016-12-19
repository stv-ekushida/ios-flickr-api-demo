//
//  PhotoSearchParamsBuilder.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoSearchParamsBuilder {

    static let perPage = 50

    static func create(tags: String, page: Int) -> [String: Any]{

        var params = FlickrBaseParamsBuilder.create()
        params["page"] = "\(page)"
        params["per_page"] = "\(perPage)"
        params["tags"] = tags
        return params
    }
}
