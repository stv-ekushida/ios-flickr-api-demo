//
//  PhotoListCollectionView.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListCollectionView: NSObject, UICollectionViewDataSource {

    fileprivate var photos: [Photo] = []
    fileprivate var status: PhotoSearchStatus?

    func add(status: PhotoSearchStatus, photos: [Photo]) {
        self.status = status
        self.photos = photos
    }

    func append(status: PhotoSearchStatus, photos: [Photo]) {
        self.status = status
            
        _ = photos.map {
            self.photos.append($0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return status!.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        return status!.create(collectionView: collectionView, indexPath: indexPath)
    }
}
