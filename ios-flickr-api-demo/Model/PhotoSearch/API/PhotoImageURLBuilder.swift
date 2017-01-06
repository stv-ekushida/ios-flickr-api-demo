//
//  PhotoImageURLBuilder.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import Foundation

final class PhotoImageURLBuilder {

    static func create(photo: Photo) -> String{
        return "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
    }
}
