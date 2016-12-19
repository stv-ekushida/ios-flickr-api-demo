//
//  APIClient.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//


import Foundation
import Alamofire
import ObjectMapper

final class APIClient<T> {

    func photosSearch(params : [String: Any],
                      completionHandler: @escaping (Result<T>) -> () = {_ in}) {

        Alamofire.request(Router.PhotosSearch(params)).responseJSON  { response in
            switch response.result {
            case .success(let value):
                if let resp = Mapper<PhotoSearchResult>().map(JSONObject: value) {
                    completionHandler(Result<T>.Success((resp as? T)!))
                }
                break

            case .failure:
                completionHandler(Result<T>.Failure(response.result.error!))
                break
            }
        }
    }
}
