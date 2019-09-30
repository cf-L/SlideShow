//
//  Medium.swift
//  Pods-SlideShow_Example
//
//  Created by Changfeng Lin on 2019/9/29.
//

import UIKit

public class Medium: NSObject {
    
    public var image: UIImage?
    public var duration: TimeInterval = 0
    public var contentMode: UIViewContentMode = .scaleAspectFit
}

public extension Medium {
    
    var imageLayer: CALayer {
        let layer = CALayer()
        layer.contents = image?.cgImage
        layer.contentsScale = UIScreen.main.scale
        layer.masksToBounds = true
        layer.backgroundColor = UIColor.black.cgColor
        layer.contentsGravity = contentMode == .scaleAspectFit ? kCAGravityResizeAspect : kCAGravityResizeAspectFill
        
        return layer
    }
}
