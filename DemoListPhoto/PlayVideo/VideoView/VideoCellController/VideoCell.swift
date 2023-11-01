//
//  VideoCell.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 01/11/2023.
//

import Foundation
import UIKit
import AVFoundation
class VideoCellCollectionView : UICollectionViewCell{
    
    static let identifier = "VideoCellCollectionView"
    
    var player :AVPlayer?
    
    var video : Video?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder:  NSCoder) {
        super.init(coder: aDecoder)
    }
    public func cellConfig(with model : Video){
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        self.video = model
        configVideo()
    }
    public func configVideo(){
        guard let video  = self.video else {return}
        guard let path = Bundle.main.path(forResource: video.videoName, ofType: "mp4") else {
            debugPrint("Video Not Found")
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerVideo = AVPlayerLayer()
        playerVideo.player = player
        playerVideo.frame = contentView.bounds
        playerVideo.videoGravity = .resizeAspectFill
        contentView.layer.addSublayer(playerVideo)
        player?.volume = 0
        video.statusLike ? player?.play() : player?.pause()
    }
    override func prepareForReuse() {
        player?.pause()
        print("Prepare for reuse")
    }
}
