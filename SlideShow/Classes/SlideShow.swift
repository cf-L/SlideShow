//
//  SlideShow.swift
//  Pods-SlideShow_Example
//
//  Created by Changfeng Lin on 2019/9/29.
//

import UIKit
import AVKit

public typealias SlideShowPlayerItem = (playerItem: AVPlayerItem, syncLayer: AVSynchronizedLayer)

public class SlideShow: NSObject {
    
    public private(set) var container = Container()
    
    private let videoTrackId = CMPersistentTrackID(1)
    private let audioTrackId = CMPersistentTrackID(3)
    private var composition = AVMutableComposition()
    
    public func makeItem(container: Container) -> SlideShowPlayerItem {
        self.container = container
        self.resetComposition()
        
        let playerItem = AVPlayerItem(asset: composition)
        
        let syncLayer = AVSynchronizedLayer(playerItem: playerItem)
        let imageLayer = createPlayableLayer()
        syncLayer.addSublayer(imageLayer)
        
        return (playerItem, syncLayer)
    }
}

private extension SlideShow {
    
    private func resetComposition() {
        self.composition = AVMutableComposition()
        _ = composition.addMutableTrack(withMediaType: .video, preferredTrackID: videoTrackId)
    }
}

private extension SlideShow {
    
    private func createPlayableLayer() -> CALayer {
        let contrainerLayer = CALayer()
        contrainerLayer.frame = CGRect(origin: .zero, size: container.resolution.size)
        contrainerLayer.backgroundColor = UIColor.black.cgColor
        
        for medium in container.media {
            
            let layer = medium.imageLayer
            layer.frame = contrainerLayer.bounds
            
            let fade = CABasicAnimation()
            fade.duration = medium.duration
            fade.toValue = 0
            fade.beginTime = container.beginTime(fro: medium)
            
            layer.add(fade, forKey: "opacity")
            
            contrainerLayer.insertSublayer(layer, at: 0)
        }
        
        return contrainerLayer
    }
}
