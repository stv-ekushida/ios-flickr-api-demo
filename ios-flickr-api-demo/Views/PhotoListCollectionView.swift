//
//  PhotoListCollectionView.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListCollectionView: NSObject, UICollectionViewDataSource {

    var photos: [Photo] = []
    var photoSearchStatusType: PhotoSearchStatusType?

    func add(photoSearchStatusType: PhotoSearchStatusType, photos: [Photo]) {
        self.photoSearchStatusType = photoSearchStatusType
        self.photos = photos
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return photoSearchStatusType?.numberOfItemsInSection(photos: photos) ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let photo: Photo? = photos.count == 0 ? nil : photos[indexPath.row]

        if let cell = photoSearchStatusType?.create(collectionView: collectionView,
                                                    indexPath: indexPath,
                                                    photo: photo)  {
            return cell
        } else {
            fatalError("UICollectionViewCellが作れません。")
        }
    }
}
