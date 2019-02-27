//
//  PhotoPresenter.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import AVKit
import Photos

class PhotoPresenter<V: PhotoView>: Presenter, PhotoConfirmedDelegate {
	typealias View = V
	
	weak var view: View!
	private var photoCapturingService: PhotoCapturingService
	
	private var timer: Timer!
	private var timeRemaining = 5
	private(set) var image: UIImage?
	var shouldCloseItselfOnConfirm = false
	var shouldSavePhotoToLibrary = true
	
	required init(view: View) {
		self.view = view
		photoCapturingService = .init()
	}
	
	func startCamera() {
		view.disableUserInteraction()
		if !photoCapturingService.isAuthorized {
			photoCapturingService.authorize { [weak self] success in
				if success {
					DispatchQueue.main.async {
						self?.setupAndStartCamera()
						self?.photoCapturingService.startCapturing()
						self?.view.enableUserInteraction()
					}
				}
			}
		} else {
			view.enableUserInteraction()
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
	
	func takePhoto() {
		stopTimer()
		view.disableUserInteraction()
		photoCapturingService.takePhoto(previewSize: view.imageSize) { [weak self] image in
			self?.image = image
			self?.view.enableUserInteraction()
			self?.view.showPreviewImage(image)
		}
	}
	
	func takePhotoWithTimer() {
		stopTimer()
		timeRemaining = 5
		view.showTimer()
		view.setTimerRemainingTime(timeRemaining)
		setupTimer()
	}
	
	private func setupTimer() {
		timer = Timer(timeInterval: 1, repeats: true, block: { [weak self] _ in
			self?.timerSecondPassed()
		})
		
		RunLoop.current.add(timer, forMode: .common)
	}
	
	private func timerSecondPassed() {
		timeRemaining -= 1
		if timeRemaining == 0 {
			view.hideTimer()
			takePhoto()
		} else {
			view.setTimerRemainingTime(timeRemaining)
		}
	}
	
	func stopTimer() {
		view.hideTimer()
		timer?.invalidate()
	}
	
	func photoConfirmed() {
		guard let image = image else { return }
		if shouldSavePhotoToLibrary {
			PHPhotoLibrary.shared().performChanges({
				PHAssetChangeRequest.creationRequestForAsset(from: image)
			}) { _, error in
				if let error = error {
					print(error)
				}
			}
		}
		if shouldCloseItselfOnConfirm {
			view.closeItself()
		}
	}
}
