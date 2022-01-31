//
//  VideoView.swift
//  Facebook_SDK
//
//  Created by Ana Mepisashvili on 30.01.22.
//

import UIKit
import AVKit
import AVFoundation

class VideoView: UIView {
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self;
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer;
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        } set {
            playerLayer.player = newValue;
        }
    }
}
