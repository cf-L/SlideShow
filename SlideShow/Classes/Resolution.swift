//
//  Resolution.swift
//  Pods-SlideShow_Example
//
//  Created by Changfeng Lin on 2019/9/29.
//

import UIKit

public struct Resolution {
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    var size: CGSize {
        return CGSize(width: width, height: height)
    }
}

extension Resolution {
    static var `default` = Resolution(width: 640, height: 640)
}
