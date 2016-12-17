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

    func add(photos: [Photo]) {
        self.photos = photos
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoListCollectionViewCell.identifier,
                                                      for: indexPath) as! PhotoListCollectionViewCell
        cell.photo = photos[indexPath.row]
        return cell
    }
}
