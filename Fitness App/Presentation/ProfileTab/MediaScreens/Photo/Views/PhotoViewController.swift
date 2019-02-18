//
//  PhotoViewController.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit
import AVKit

class PhotoViewController: UIViewController {
	var presenter: PhotoPresenter<PhotoViewController>!
	
	@IBOutlet private weak var cameraView: CameraView!
	@IBOutlet private weak var takePhotoButton: UIButton!
	@IBOutlet private weak var timerLabel: UILabel!
	@IBOutlet private weak var photoLevelView: PhotoLevelView!
	
	private var statusBarShouldBeHidden = false
	
	override var prefersStatusBarHidden: Bool {
		return statusBarShouldBeHidden
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter.startCamera()
		
		statusBarShouldBeHidden = false
		UIView.animate(withDuration: 0.25) {
			self.setNeedsStatusBarAppearanceUpdate()
		}
		
		photoLevelView.startUpdate()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		presenter.stopCamera()
		presenter.stopTimer()
		
		photoLevelView.stopUpdate()
	}
	
	@IBAction private func takePhotoTapped() {
		presenter.takePhoto()
	}
	
	@IBAction private func timerTapped() {
		presenter.takePhotoWithTimer()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let photoPreviewVC = segue.destination as? PhotoPreviewViewController,
			let image = sender as? UIImage {
			photoPreviewVC.photo = image
		}
	}
	
}

extension PhotoViewController: PhotoView {
	func showTimer() {
		timerLabel.isHidden = false
	}
	
	func hideTimer() {
		timerLabel.isHidden = true
	}
	
	func setTimerRemainingTime(_ time: Int) {
		timerLabel.text = "\(time)"
	}
	
	func disableUserInteraction() {
		view.isUserInteractionEnabled = false
	}
	
	func enableUserInteraction() {
		view.isUserInteractionEnabled = true
	}
	
	var videoPreviewLayer: AVCaptureVideoPreviewLayer {
		return cameraView.videoPreviewLayer
	}
	
	var imageSize: CGSize {
		return cameraView.bounds.size
	}
	
	func showPreviewImage(_ image: UIImage) {
		statusBarShouldBeHidden = true
		
		UIView.animate(withDuration: 0.25) {
			self.setNeedsStatusBarAppearanceUpdate()
		}
		performSegue(withIdentifier: .presentPhotoPreviewSegueIdentifier, sender: image)
	}
}


