//
//  PhotoSearchStatus.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

enum PhotoSearchStatus {
    case none
    case loading
    case noData
    case normal(PhotoSearchResult)
    case offline
    case error
    
    func create(collectionView: UICollectionView,
                     indexPath: IndexPath,
                     photos: [Photo]) -> UICollectionViewCell {
    
        switch self {
        case .normal:
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PhotoListCollectionViewCell.identifier,
                for: indexPath) as! PhotoListCollectionViewCell
            
            cell.photo = photos[indexPath.row]
            return cell
            
        default:
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PhotoListIllegalCollectionViewCell.identifier,
                for: indexPath) as! PhotoListIllegalCollectionViewCell
            
            cell.message = message()
            return cell
        }
    }
    
    func numberOfItemsInSection(photos: [Photo]) -> Int {
        
        switch self {
        case .normal:
            return photos.count
            
        default:
            return 1
        }
    }

    func message() -> String {
        
        switch self {
        case .none:
            return NSLocalizedString("MSG_NONE", comment: "")
            
        case .loading:
            return NSLocalizedString("MSG_LOADING", comment: "")
            
        case .normal:
            fatalError("このパターンはありません")
            
        case .noData:
            return NSLocalizedString("MSG_NODATA", comment: "")
            
        case .offline:
            return NSLocalizedString("MSG_OFFLINE", comment: "")
            
        case .error:
            fatalError("通信エラーが発生しました。")
        }
    }
    
    func cellCize() -> CGSize {

        let topMargin = CGFloat(110)
        let screenSize = UIScreen.main.bounds
        
        switch self {
        case . normal:
            let screenPerWidth = CGFloat(3)
            let screenPerrHeight = CGFloat(5)
            
            let cellWidth = screenSize.width / screenPerWidth
            let cellHeight = (screenSize.height - topMargin) / screenPerrHeight

            return CGSize(width: cellWidth, height: cellHeight)
        
        default:
            
            let cellWidth = screenSize.width
            let cellHeight = (screenSize.height - topMargin)
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
}
