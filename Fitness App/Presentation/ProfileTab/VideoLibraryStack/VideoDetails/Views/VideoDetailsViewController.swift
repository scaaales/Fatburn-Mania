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
	@IBOutlet private weak var videoContainter: UIView!
	@IBOutlet private weak var playButton: UIButton!
	@IBOutlet private weak var descriptionLabel: UILabel!
	
	private var player: AVPlayer!
	
	private var isPlaying = false
	private var playerLayerCreated = false
	var video: Video!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		guard let videoUrlFixed = video.video.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
			let videoURL = URL(string: videoUrlFixed) else { return }
		player = AVPlayer(url: videoURL)
		descriptionLabel.text = video.text
		title = video.title
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if !playerLayerCreated {
			setupPlayerLayer()
		}
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
		playerLayerCreated = true
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

