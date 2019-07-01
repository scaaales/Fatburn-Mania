//
//  PhotoView.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import AVKit

protocol PhotoView: View {
	var videoPreviewLayer: AVCaptureVideoPreviewLayer { get }
	var imageSize: CGSize { get }
	func showPreviewImage(_ image: UIImage)
	func disableUserInteraction()
	func enableUserInteraction()
	
	func closeItself()
//	func closeItself(completion: @escaping () -> Void)
	
	func showTimer()
	func hideTimer()
	func setTimerRemainingTime(_ time: Int)
}
