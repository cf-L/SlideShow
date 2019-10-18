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
    
    private let videoTrackId = CMPersistentTrackID(1001)
    private let audioTrackId = CMPersistentTrackID(1003)
    private var composition = AVMutableComposition()
    
    private lazy var blankAsset: AVURLAsset? = {
        guard let url = resourceBundle?.url(forResource: "blank_1080p", withExtension: "mp4")
            else { return nil }
        return AVURLAsset(url: url)
    }()
    
    public func makeItem(container: Container) -> SlideShowPlayerItem {
        self.container = container
        self.resetComposition()
        
        let playerItem = AVPlayerItem(asset: composition)
        
        let syncLayer = AVSynchronizedLayer(playerItem: playerItem)
        let imageLayer = createPlayableLayer()
        syncLayer.addSublayer(imageLayer)
        syncLayer.frame = CGRect(origin: .zero, size: container.resolution.size)
        
        return (playerItem, syncLayer)
    }
}

private extension SlideShow {
    
    private func resetComposition() {
        self.composition = AVMutableComposition()
        
        let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: videoTrackId)
        
        if let track = blankAsset?.tracks(withMediaType: .video).last {
            
            let duration = CMTimeMakeWithSeconds(container.duration, preferredTimescale: track.timeRange.duration.timescale)
            let timeRange = CMTimeRange(start: .zero, duration: duration)
            
            do {
                try compositionVideoTrack?.insertTimeRange(timeRange, of: track, at: .zero)
            } catch {
                print(error)
            }
        }
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
            
            let fade = CABasicAnimation(keyPath: "opacity")
            fade.duration = medium.duration
            fade.toValue = 0
            fade.beginTime = container.beginTime(for: medium)
            fade.isRemovedOnCompletion = false
            fade.fillMode = .forwards
            
            layer.add(fade, forKey: "opacity")
            
            contrainerLayer.insertSublayer(layer, at: 0)
        }
        
        return contrainerLayer
    }
}

extension SlideShow {
    
}

extension SlideShow {
    var resourceBundle: Bundle? {
        let bundle = Bundle(for: SlideShow.self)
        if let url = bundle.url(forResource: "SlideShow", withExtension: "bundle") {
            return Bundle(url: url)
        }
        return nil
    }
}
