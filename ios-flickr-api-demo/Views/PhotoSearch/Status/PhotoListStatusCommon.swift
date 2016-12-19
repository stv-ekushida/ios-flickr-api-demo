//
//  PhotoListStatusCommon.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2016/12/18.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListStatusCommon: PhotoListStatusable {

    func numberOfItemsInSection(photos: [Photo]) -> Int {
        return 1
    }

    func create(collectionView: UICollectionView,
                indexPath: IndexPath,
                photo: Photo?) -> UICollectionViewCell {
        fatalError("このメソッドは利用できません")
    }

    func cellSize(topOf: PhotoListViewController) -> CGSize {

        let topMargin = CGFloat(110)
        let screenSize = UIScreen.main.bounds
        let cellWidth = screenSize.width
        let cellHeight = (screenSize.height - topMargin)

        return CGSize(width: cellWidth, height: cellHeight)
    }
}
