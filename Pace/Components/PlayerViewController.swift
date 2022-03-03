//
//  PlayerViewController.swift
//  Finetic
//
//  Created by Tapiwa on 2021-03-06.
//

import Foundation
import AVKit
import SwiftUI

struct PlayerViewController: UIViewControllerRepresentable {
    var videoURL: URL?


    private var player: AVPlayer {
        return AVPlayer(url: videoURL!)
    }


    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller =  AVPlayerViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.player = player
        controller.player?.play()
        return controller
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {

    }
}
