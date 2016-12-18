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

    func updateView(result: PhotoSearchResult?, topOf: PhotoListViewController) {

        if let pages = result?.photos?.pages, let photos = result?.photos {
            topOf.page.updatePages(pages: pages)
            appendPhoto(photos: photos.photo.map {$0}, topOf: topOf)
        }
        scrollToTop(topOf: topOf)
    }

    fileprivate func appendPhoto(photos: [Photo], topOf: PhotoListViewController) {

        _ = photos.map {
            topOf.photos.append($0)
        }
        topOf.dataSource.add(photoSearchStatusable: self, photos: topOf.photos)
    }

    fileprivate func scrollToTop(topOf: PhotoListViewController) {

        if topOf.page.currentPage() == 1 {
            topOf.collectionView.scrollToTop()
        }
    }
}
