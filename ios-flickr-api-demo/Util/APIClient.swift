//
//  APIClient.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//


import Foundation
import Alamofire

enum Result {
    case Success(Any)
    case Failure(Error)
}

final class APIClient {

    func request(params : [String: Any],
                      completionHandler: @escaping (Result) -> () = {_ in}) {

        Alamofire.request(Router.PhotosSearch(params)).responseJSON  { response in
            switch response.result {
            case .success(let value):                
                completionHandler(Result.Success(value))

            case .failure:
                
                if let error = response.result.error {
                    completionHandler(Result.Failure(error))
                } else {
                    fatalError("エラーのインスタンスがnil")
                }
            }
        }
    }
}
