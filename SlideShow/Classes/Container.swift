//
//  Container.swift
//  Pods-SlideShow_Example
//
//  Created by Changfeng Lin on 2019/9/29.
//

import UIKit
import AVKit

public class Container: NSObject {
    
    public var audios: [Audio] = []
    public var media: [Medium] = []
    
    public var resolution = Resolution.default
    
    public var duration: CFTimeInterval {
        return media.reduce(0, { $0 + $1.duration })
    }
    
    public func beginTime(for medium: Medium) -> CFTimeInterval {
        guard media.contains(medium) else { return AVCoreAnimationBeginTimeAtZero }
        
        var time: CFTimeInterval = AVCoreAnimationBeginTimeAtZero
        
        for item in media {
            if item == medium { break }
            time += item.duration
        }
        
        return time
    }
}
