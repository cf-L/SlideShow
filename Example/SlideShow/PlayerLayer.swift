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
    
    override public class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var avLayer: AVPlayerLayer? {
        return self.layer as? AVPlayerLayer
    }

    var player: AVPlayer? {
        get {
            return avLayer?.player
        }
        set {
            avLayer?.player = newValue
        }
    }
}
