//
//  VideosTableViewCell.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 26.01.22.
//

import UIKit
import AVKit
import AVFoundation

class VideosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoView: VideoView!
    @IBOutlet weak var createdTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var queuePlayer = AVQueuePlayer()
    private var playerLayer = AVPlayerLayer()
    private var looperPlayer: AVPlayerLooper?
    
    var playing: Bool = false
    
    public var videoUrl: URL? = nil {
        didSet {
            guard let url = videoUrl, oldValue != url else { return }
            loadVideoUsingURL(url)
        }
    }
    
    func configureVideo(with video: VideosModel) {
        descriptionLabel.text = video.message
        videoUrl = NSURL(string: video.video_url) as URL?
        createdTimeLabel.text = video.created_time

    }
    func configureVideo(with video: PostsModel) {
        descriptionLabel.text = video.message
        videoUrl = NSURL(string: video.video_url) as URL?
    }
   
    func startVideo() {
        queuePlayer.play()
        playing = true
    }
    
    func stopVideo() {
        queuePlayer.pause()
        playing = false
    }
    required init? (coder aDecoder: NSCoder) {
        super.init (coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        queuePlayer.volume = 0.0
        queuePlayer.actionAtItemEnd = .none
        playerLayer.videoGravity = .resizeAspect
        playerLayer.name = "videoLoopLayer"
        playerLayer.cornerRadius = 5.0
        playerLayer.masksToBounds = true
        contentView.layer.addSublayer(playerLayer)
        playerLayer.player = queuePlayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = videoView.frame
    }
    
    private func loadVideoUsingURL(_ url: URL) {
        DispatchQueue.global(qos: .background).async {
            let asset = AVURLAsset(url: url)
            asset.loadValuesAsynchronously(forKeys: ["duration", "playable"]) {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    let item = AVPlayerItem(asset: asset)
                    if self.queuePlayer.currentItem != item {
                        self.queuePlayer.replaceCurrentItem(with: item)
                        self.looperPlayer = AVPlayerLooper(player: self.queuePlayer, templateItem: item)
                        
                    }
                }
            }
        }
    }
}
