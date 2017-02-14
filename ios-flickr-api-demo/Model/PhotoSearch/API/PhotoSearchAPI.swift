//
//  PhotoSearchAPI.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import Foundation
import ObjectMapper

final class PhotoSearchAPI {

    var loadable: PhotoSearchLoadable?
    fileprivate var isLoading = false
    private var requestCount = 1
    private var totalCount = 1

    func waiting() -> Bool {
        return isLoading
    }

    func load(tags: String) {

        guard NetworkManager.isAvailable() else {
            self.loadable?.setStatus(status: .offline)
            return
        }
        
        isLoading = true

        let router = Router.PhotosSearch(
            PhotoSearchParamsBuilder.create(tags: tags, page: current()))
        
        APIClient().request(router:router) { [weak self](response) -> () in

            switch response {
            case .Success(let result):
                                
                 if let searchResult = Mapper<PhotoSearchResult>().map(JSONObject: result) {                    
                    let status = self?.hasPhotoList(result: searchResult) ?? .none
                    self?.loadable?.setStatus(status: status)
                 }

            case .Failure( _):
                self?.loadable?.setStatus(status: .error)
            }
            self?.isLoading = false
        }
    }

    private func hasPhotoList(result: PhotoSearchResult) -> PhotoListStatus{

        return (result.photos?.photo.count == 0) ?
            PhotoListStatus.noData : PhotoListStatus.normal(result)
    }
    
    //MARK:- リクエスト回数の管理
    func current() -> Int {
        return requestCount
    }
    
    func reset() {
        requestCount = 1
    }
    
    func incement() {
        requestCount += 1
    }
    
    func updateTotal(total: Int) {
        self.totalCount = total
    }
    
    func isMoreRequest() -> Bool{
        return totalCount > requestCount * PhotoSearchParamsBuilder.perPage
    }
}
