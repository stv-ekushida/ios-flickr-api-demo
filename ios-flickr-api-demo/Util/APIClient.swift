//
//  APIClient.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

final class APIClient<T> {

    func buildParams() -> [String: Any] {

        return [
            "method" : "flickr.photos.search",
            "api_key" : "10ba93bbe49a6480d765ce486673954a",
            "nojsoncallback" : "1",
            "format": "json"]
    }

    func photosSearch(params : [String: Any],
                      completionHandler: @escaping (Result<T>) -> () = {_ in}) {

        Alamofire.request(Router.PhotosSearch(params))
            .validate()
            .responseJSON {response in
                if response.result.isSuccess {

                    let resp = response.result.value as! [String: Any]
                    let result = PhotoSearchParser.parse(json: JSON(resp["photos"] ?? []))
                    completionHandler(Result<T>.Success((result as? T)!))

                } else {
                    completionHandler(Result<T>.Failure(response.result.error!))
                }
        }
    }
}
