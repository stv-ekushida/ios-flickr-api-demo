//
//  FlickrBaseParamsBuilder.swift
//  ios-flickr-api-demo
//
//  Created by Kushida　Eiji on 2016/12/19.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import Foundation
import Keys

final class FlickrBaseParamsBuilder {
    
    static func create() -> [String: Any] {
        
        return [
            "method" : "flickr.photos.search",
            "api_key" : IosFlickrApiDemoKeys().api_key,
            "nojsoncallback" : "1",
            "format": "json"]
    }
}
