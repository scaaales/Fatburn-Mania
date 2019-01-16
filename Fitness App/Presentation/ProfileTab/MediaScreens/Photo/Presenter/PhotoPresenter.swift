//
//  PhotoPresenter.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import AVKit

class PhotoPresenter<V: PhotoView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var photoCapturingService: PhotoCapturingService
	
	required init(view: View) {
		self.view = view
		photoCapturingService = .init()
	}
	
	func startCamera() {
		if !photoCapturingService.isAuthorized {
			photoCapturingService.authorizate { [weak self] success in
				if success {
					DispatchQueue.main.async {
						self?.setupAndStartCamera()
						self?.photoCapturingService.startCapturing()
					}
				}
			}
		} else {
			photoCapturingService.startCapturing()
		}
	}
	
	private func setupAndStartCamera() {
		photoCapturingService.setupPhotoCapturing()
		photoCapturingService.setVideoPreviewLayer(view.videoPreviewLayer)
	}
	
	func stopCamera() {
		photoCapturingService.endCapturing()
	}
}
