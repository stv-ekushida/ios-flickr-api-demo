//
//  PhotoListFactory.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2017/01/06.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListFactory: NSObject {

    private var statusType: PhotoListStatusType?

    func setStatus(status: PhotoListStatus) {

        switch status {
        case .none:
            statusType = PhotoListStatusNone()

        case .loading:
            statusType = PhotoListStatusLoading()

        case .normal:
            statusType = PhotoListStatusNormal()

        case .noData:
            statusType = PhotoListStatusNoData()

        case .offline:
            statusType = PhotoListStatusOffline()

        default:
            fatalError("NGパターンです")
        }
    }

    func create(collectionView: UICollectionView,
                indexPath: IndexPath,
                photos: [Photo]) -> UICollectionViewCell {

        return statusType?.create(collectionView: collectionView,
                              indexPath: indexPath,
                              photos: photos) ?? UICollectionViewCell()
    }

    func numberOfItemsInSection(photos: [Photo]) -> Int {
        return statusType?.numberOfItemsInSection(photos: photos) ?? 0
    }

    func message() -> String {
        return statusType?.message() ?? ""
    }
    func cellSize() -> CGSize {
        return statusType?.cellSize() ?? CGSize.zero
    }
}
