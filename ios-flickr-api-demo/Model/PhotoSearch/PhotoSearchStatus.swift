//
//  PhotoSearchStatus.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import Foundation

enum PhotoSearchStatus {
    case none
    case noData
    case normal(PhotoSearchResult)
    case offline
    case error

    func type() -> PhotoListStatusable{

        switch self {
        case .none:
            return PhotoListStatusNone()

        case .normal:
            return PhotoListStatusNormal()

        case .noData:
            return PhotoListStatusNoData()

        case .offline:
            return PhotoListStatusOffline();

        case .error:
            fatalError("通信エラーが発生しました。")
        }
    }
}
