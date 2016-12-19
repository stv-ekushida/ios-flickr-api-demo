//
//  PhotoListStatusOffline.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2016/12/18.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListStatusOffline: PhotoListStatusable {

    let message = NSLocalizedString("MSG_OFFLINE",
                                    comment: "オフライン時のメッセージ")
    let commonStatusable = PhotoListStatusCommon()

    func numberOfItemsInSection(photos: [Photo]) -> Int {
        return commonStatusable.numberOfItemsInSection(photos: photos)
    }

    func create(collectionView: UICollectionView,
                indexPath: IndexPath,
                photo: Photo?) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoListIllegalCollectionViewCell.identifier,
            for: indexPath) as! PhotoListIllegalCollectionViewCell

        cell.message = message
        return cell
    }

    func cellSize() -> CGSize {
        return commonStatusable.cellSize()
    }
}
