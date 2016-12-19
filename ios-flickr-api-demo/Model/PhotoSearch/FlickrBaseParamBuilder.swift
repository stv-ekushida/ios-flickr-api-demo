//
//  FlickrBaseParamBuilder.swift
//  ios-flickr-api-demo
//
//  Created by Kushida　Eiji on 2016/12/19.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import Foundation

final class FlickrBaseParamBuilder {
    
    static func create() -> [String: Any] {
        
        return [
            "method" : "flickr.photos.search",
            "api_key" : "10ba93bbe49a6480d765ce486673954a",
            "nojsoncallback" : "1",
            "format": "json"]
    }
}
