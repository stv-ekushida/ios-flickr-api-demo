//
//  PhotoListStatusType.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2017/01/06.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol PhotoListStatusType {
    func create(collectionView: UICollectionView,
                indexPath: IndexPath,
                photos: [Photo]) -> UICollectionViewCell
    func numberOfItemsInSection(photos: [Photo]) -> Int
    func message() -> String
    func cellSize() -> CGSize
}

extension PhotoListStatusType where Self: NSObject{

    func create(collectionView: UICollectionView,
                indexPath: IndexPath,
                photos: [Photo]) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoListIllegalCollectionViewCell.identifier,
            for: indexPath) as! PhotoListIllegalCollectionViewCell

        cell.messageTextView.text = self.message()
        return cell
    }

    func numberOfItemsInSection(photos: [Photo]) -> Int {
        return 1
    }

    func cellSize() -> CGSize {

        let topMargin = CGFloat(110)
        let screenSize = UIScreen.main.bounds
        let cellWidth = screenSize.width
        let cellHeight = (screenSize.height - topMargin)
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
