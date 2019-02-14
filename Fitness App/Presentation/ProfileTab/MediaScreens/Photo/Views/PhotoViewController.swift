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
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		presenter.stopCamera()
	}
	
	@IBAction private func takePhotoTapped(_ sender: Any) {
		presenter.takePhoto()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let photoPreviewVC = segue.destination as? PhotoPreviewViewController,
			let image = sender as? UIImage {
			photoPreviewVC.photo = image
		}
	}
	
}

extension PhotoViewController: PhotoView {
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


