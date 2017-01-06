//
//  PhotoListCollectionViewCell.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit
import AlamofireImage

final class PhotoListCollectionViewCell: UICollectionViewCell{

    @IBOutlet weak var photoImageView: UIImageView!

    static var identifier: String {
        get {
            return String(describing: self)
        }
    }

    var photo: Photo? = nil {

        didSet {

            if let photo = photo {
                self.photoURL = PhotoImageURLBuilder.create(photo: photo)
            }
        }
    }

    fileprivate var photoURL: String = "" {

        didSet {

            if let url = URL(string: photoURL) {
                self.photoImageView.af_setImage(withURL: url)
            } else {
                fatalError("写真のURLが不正")
            }
        }
    }

    override func prepareForReuse() {
        self.photoImageView.image = nil
    }
}
