//
//  PhotoListStatus.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

enum PhotoListStatus {
    case none
    case loading
    case noData
    case normal(PhotoSearchResult)
    case offline
    case error
}
