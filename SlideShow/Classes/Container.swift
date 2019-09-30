//
//  Container.swift
//  Pods-SlideShow_Example
//
//  Created by Changfeng Lin on 2019/9/29.
//

import UIKit

public class Container: NSObject {
    
    public var audios: [Audio] = []
    public var media: [Medium] = []
    
    public var resolution = Resolution.default
    
    public var duration: TimeInterval {
        return media.reduce(0, { $0 + $1.duration })
    }
    
    public func beginTime(fro medium: Medium) -> TimeInterval {
        guard media.contains(medium) else { return 0 }
        
        var time: TimeInterval = 0
        for item in media {
            if item == medium { break }
            
            time += item.duration
        }
        
        return time
    }
}
