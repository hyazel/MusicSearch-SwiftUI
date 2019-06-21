//
//  DZRPlayer.swift
//  DeezerPlayground
//
//  Created by laurent.droguet on 01/05/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation
import AVFoundation

protocol DZRPlayerDelegate: class {
    func playerPaused()
    func playerPlayed()
}

class DZRPlayer {
    
    static let shared = DZRPlayer()
    var player: AVPlayer!
    var playerItem: AVPlayerItem?
    var delegate: DZRPlayerDelegate?
    
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        } catch {
            print("Problem with the Player")
        }
    }
    
    func playFileFromUrl(_ urlPath: String) {
        let url = URL(fileURLWithPath: urlPath)
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player.play()
        delegate?.playerPlayed()
    }
}
