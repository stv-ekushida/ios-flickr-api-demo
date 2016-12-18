//
//  PhotoListIllegalCollectionViewCell.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2016/12/18.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListIllegalCollectionViewCel: UICollectionViewCell{

    @IBOutlet weak var messageTextView: UITextView!

    static var identifier: String {
        get {
            return String(describing: self)
        }
    }

    var message = "" {

        didSet {
            messageTextView.text = message
        }
    }
}
