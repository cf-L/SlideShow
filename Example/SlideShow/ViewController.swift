//
//  ViewController.swift
//  SlideShow
//
//  Created by cf-L on 09/29/2019.
//  Copyright (c) 2019 cf-L. All rights reserved.
//

import UIKit
import AVKit
import SnapKit
import SlideShow

class ViewController: UIViewController {
    
    lazy var images: [UIImage?] = {
        return (0...6).map{ UIImage(named: "image\($0).jpeg") }
    }()
    
    lazy var playerLayer: PlayerLayer = {
        let player = PlayerLayer()
        return player
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        
        let media: [Medium] = images.map { (image) -> Medium in
            let medium = Medium()
            medium.image = image
            medium.duration = 2
            return medium
        }
        
        let container = Container()
        container.media = media
        
        let sliderShow = SlideShow()
        let item = sliderShow.makeItem(container: container)
        
        playerLayer.player = AVPlayer(playerItem: item.playerItem)
//        playerLayer.avLayer?.addSublayer(item.syncLayer)
        playerLayer.layer.addSublayer(item.syncLayer)
        
        playerLayer.player?.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UI
extension ViewController {
    
    func setupUI() {
        view.addSubview(playerLayer)
    }
    
    func setupConstraints() {
        playerLayer.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(640)
        }
    }
}
