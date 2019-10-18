//
//  PlayerLayer.swift
//  SlideShow_Example
//
//  Created by Changfeng Lin on 2019/9/29.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import AVKit

class PlayerLayer: UIView {
    
    var avLayer = AVPlayerLayer()

    var player: AVPlayer? {
        get {
            return avLayer.player
        }
        set {
            avLayer.player = newValue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avLayer.frame = bounds
    }
}
