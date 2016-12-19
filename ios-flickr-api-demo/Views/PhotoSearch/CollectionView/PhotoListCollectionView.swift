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
    fileprivate var photoSearchStatusable: PhotoListStatusable?

    func add(photoSearchStatusable: PhotoListStatusable, photos: [Photo]) {
        self.photoSearchStatusable = photoSearchStatusable
        self.photos = photos
    }

    func append(photoSearchStatusable: PhotoListStatusable, photos: [Photo]) {
        self.photoSearchStatusable = photoSearchStatusable
        
        _ = photos.map {
            self.photos.append($0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return photoSearchStatusable?.numberOfItemsInSection(photos: photos) ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let photo: Photo? = photos.count == 0 ? nil : photos[indexPath.row]

        if let cell = photoSearchStatusable?.create(collectionView: collectionView,
                                                    indexPath: indexPath,
                                                    photo: photo)  {
            return cell
        } else {
            fatalError("UICollectionViewCellが作れません。")
        }
    }
}
