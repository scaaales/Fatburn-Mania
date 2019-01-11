//
//  VideoDetailsViewController.swift
//  Fitness App
//
//  Created by scales on 1/11/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit
import AVKit

class VideoDetailsViewController: UIViewController {
	var presenter: VideoDetailsPresenter<VideoDetailsViewController>!
	
	@IBOutlet private weak var videoContainter: UIView!
	@IBOutlet private weak var playButton: UIButton!
	@IBOutlet private weak var descriptionTextView: UITextView!
	
	private var player: AVPlayer!
	
	private var isPlaying = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let url = URL(string: "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8")!
		player = AVPlayer(url: url)
		setupPlayerLayer()
		descriptionTextView.text = .loremIpsumConstant
	}
	
	private func setupPlayerLayer() {
		let playerLayer = AVPlayerLayer(player: player)
		playerLayer.videoGravity = .resizeAspectFill
		playerLayer.frame = videoContainter.bounds
		let path = UIBezierPath(roundedRect: videoContainter.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 20, height: 20))
		let newMaskLayer = CAShapeLayer()
		newMaskLayer.path = path.cgPath
		videoContainter.layer.mask = newMaskLayer
		
		videoContainter.layer.addSublayer(playerLayer)
	}
	
	@IBAction private func playPause(_ sender: Any) {
		if isPlaying {
			player.pause()
			playButton.setImage(#imageLiteral(resourceName: "playIcon"), for: .normal)
		} else {
			player.play()
			playButton.setImage(nil, for: .normal)
		}
		isPlaying.toggle()
	}
	
}

extension VideoDetailsViewController: VideoDetailsView {
	
}


