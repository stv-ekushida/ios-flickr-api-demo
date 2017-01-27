//
//  MocPhotoList.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2017/01/27.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Foundation
import ObjectMapper
@testable import ios_flickr_api_demo

final class MocPhotoList {
    
    func feachTestData() -> PhotoSearchResult{
        
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "flickr", ofType: "json")
        if let path = path {
            
            let fileHandle = FileHandle(forReadingAtPath: path)
            let jsonData = fileHandle?.readDataToEndOfFile()
            
            if let jsonData = jsonData {
                
                let json = String(data: jsonData,
                                  encoding: String.Encoding.utf8)
                
                if let json = json {
                    
                    if let searchResult = Mapper<PhotoSearchResult>().map(JSONString: json) {
                        return searchResult
                    }
                }
            }
        }
        fatalError("テストデータが読み込めない")
    }
}
