//
//  PhotoSearchLoadable.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import Foundation

protocol PhotoSearchLoadable{
    func setStatus(status: PhotoSearchStatus)
    func completed(result: PhotoSearchResult)
}
