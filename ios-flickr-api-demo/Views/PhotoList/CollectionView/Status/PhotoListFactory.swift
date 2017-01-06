//
//  PhotoListFactory.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2017/01/06.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListFactory: NSObject {

    private var viewType: PhotoListStatusType?

    func setStatus(status: PhotoListStatus) {

        switch status {
        case .none:
            viewType = PhotoListStatusNone()

        case .loading:
            viewType = PhotoListStatusLoading()

        case .normal:
            viewType = PhotoListStatusNormal()

        case .noData:
            viewType = PhotoListStatusNoData()

        case .offline:
            viewType = PhotoListStatusOffline()

        default:
            fatalError("NGパターンです")
        }
    }

    func create(collectionView: UICollectionView,
                indexPath: IndexPath,
                photos: [Photo]) -> UICollectionViewCell {

        return viewType?.create(collectionView: collectionView,
                              indexPath: indexPath,
                              photos: photos) ?? UICollectionViewCell()
    }

    func numberOfItemsInSection(photos: [Photo]) -> Int {
        return viewType?.numberOfItemsInSection(photos: photos) ?? 0
    }

    func message() -> String {
        return viewType?.message() ?? ""
    }
    func cellSize() -> CGSize {
        return viewType?.cellSize() ?? CGSize.zero
    }
}
