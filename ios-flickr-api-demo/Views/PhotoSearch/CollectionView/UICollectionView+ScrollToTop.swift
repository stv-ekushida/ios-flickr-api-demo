//
//  UICollectionView+ScrollToTop.swift
//  ios-flickr-api-demo
//
//  Created by Eiji Kushida on 2016/12/18.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

extension UICollectionView {

    func scrollToTop() {
        self.contentOffset = CGPoint(x: 0, y: -self.contentInset.top)
    }
}
