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
	
	@IBOutlet private weak var photoPreviewView: PhotoPreviewView!
	@IBOutlet private weak var takePhotoButton: UIButton!
	@IBOutlet private weak var photoPreviewImageView: UIImageView!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter.startCamera()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		presenter.stopCamera()
	}
	
	@IBAction private func takePhotoTapped(_ sender: Any) {
		presenter.takePhoto()
	}
	
}

extension PhotoViewController: PhotoView {
	var videoPreviewLayer: AVCaptureVideoPreviewLayer {
		return photoPreviewView.videoPreviewLayer
	}
	
	var imageSize: CGSize {
		return photoPreviewView.bounds.size
	}
	
	func setPreviewImage(_ image: UIImage) {
		photoPreviewImageView.image = image
	}
	
}

