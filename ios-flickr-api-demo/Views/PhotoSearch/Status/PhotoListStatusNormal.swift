//
//  PhotoListStatusNormal.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2016/12/18.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListStatusNormal: PhotoListStatusable {

    func numberOfItemsInSection(photos: [Photo]) -> Int {
        return photos.count
    }

    func create(collectionView: UICollectionView,
                indexPath: IndexPath,
                photo: Photo?) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoListCollectionViewCell.identifier,
            for: indexPath) as! PhotoListCollectionViewCell

        cell.photo = photo
        return cell
    }

    func cellSize(topOf: PhotoListViewController) -> CGSize {

        let screenPerWidth = CGFloat(3)
        let screenPerrHeight = CGFloat(5)
        let topMargin = CGFloat(110)

        let screenSize = UIScreen.main.bounds
        let cellWidth = screenSize.width / screenPerWidth
        let cellHeight = (screenSize.height - topMargin) / screenPerrHeight

        return CGSize(width: cellWidth, height: cellHeight)
    }    
}
