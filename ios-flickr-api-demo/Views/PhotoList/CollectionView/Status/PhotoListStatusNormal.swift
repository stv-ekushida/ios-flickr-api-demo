//
//  PhotoListStatusNormal.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2017/01/06.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListStatusNormal: PhotoListStatusType {

    func create(collectionView: UICollectionView,
                indexPath: IndexPath,
                photos: [Photo]) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoListCollectionViewCell.identifier,
            for: indexPath) as! PhotoListCollectionViewCell

        cell.photo = photos[indexPath.row]
        return cell
    }

    func numberOfItemsInSection(photos: [Photo]) -> Int {
        return photos.count
    }

    func message() -> String {
        fatalError("このパターンはありません")
    }

    func cellSize() -> CGSize {

        let topMargin = CGFloat(110)
        let screenSize = UIScreen.main.bounds
        let screenPerWidth = CGFloat(3)
        let screenPerrHeight = CGFloat(5)

        let cellWidth = screenSize.width / screenPerWidth
        let cellHeight = (screenSize.height - topMargin) / screenPerrHeight

        return CGSize(width: cellWidth, height: cellHeight)
    }
}
