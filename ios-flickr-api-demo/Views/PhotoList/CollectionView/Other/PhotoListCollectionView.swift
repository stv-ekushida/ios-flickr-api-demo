//
//  PhotoListCollectionView.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListCollectionView: NSObject {

    fileprivate let factory = PhotoListFactory()
    fileprivate var photos: [Photo] = []
    private var status: PhotoListStatus? {
        didSet {

            if let status = status {
                factory.setStatus(status: status)
            }
        }
    }

    func add(status: PhotoListStatus, photos: [Photo]) {
        self.status = status
        self.photos = photos
    }

    func append(status: PhotoListStatus, photos: [Photo]) {
        self.status = status
            
        _ = photos.map {
            self.photos.append($0)
        }
    }

    func view() -> PhotoListFactory {
        return factory
    }
}

//MARK:- UICollectionViewDataSource
extension PhotoListCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return factory.numberOfItemsInSection(photos: self.photos)
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        return factory.create(collectionView: collectionView,
                             indexPath: indexPath,
                             photos: self.photos)
    }
}
