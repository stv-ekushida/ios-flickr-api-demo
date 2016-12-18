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
    case normal
    case offline
    case error

    func type() -> PhotoSearchStatusType{

        switch self {
        case .none:
            return PhotoListNone()

        case .normal:
            return PhotoListNormal()

        case .noData:
            return PhotoListNoData()

        case .offline:
            return PhotoListOffline();

        case .error:
            fatalError("通信エラーが発生しました。")
        }
    }
}
