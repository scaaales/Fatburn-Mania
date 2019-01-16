//
//  CollageViewController.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit
import Photos

class CollageViewController: UIViewController {
	var presenter: CollagePresenter<CollageViewController>!
	
	@IBOutlet private weak var leftImageView: UIImageView!
	@IBOutlet private weak var rightImageView: UIImageView!
	@IBOutlet private weak var addLeftImageButton: UIButton!
	@IBOutlet private weak var addRightImageButton: UIButton!
	
	private var selectedImageViewToAdd: UIImageView?
	private var selectedButtonToAddImage: UIButton?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		leftImageView.layer.masksToBounds = true
		rightImageView.layer.masksToBounds = true
	}
	
	@IBAction private func addLeftImageTapped() {
		selectedButtonToAddImage = addLeftImageButton
		loadPhotoInto(into: leftImageView)
	}
	
	@IBAction private func addRightImageTapped() {
		selectedButtonToAddImage = addRightImageButton
		loadPhotoInto(into: rightImageView)
	}
	
	@IBAction private func rotateLeftImageLeftTapped() {
		
	}
	
	@IBAction private func rotateLeftImageRightTapped() {
		
	}
	
	@IBAction private func rotateRightImageLeftTapped() {
		
	}
	
	@IBAction private func rotateRightImageRightTapped() {
		
	}
	
	@IBAction private func reduceTapped() {
		
	}
	
	@IBAction private func zoopTapped() {
		
	}
	
	@IBAction private func saveTapped() {
		
	}
	
}

private extension CollageViewController {
	func loadPhotoInto(into imageView: UIImageView) {
		let available = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
		guard available else { return }
		selectedImageViewToAdd = imageView
		
		let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
		switch photoAuthorizationStatus {
		case .authorized:
			presentImagePicker()
		case .notDetermined:
			PHPhotoLibrary.requestAuthorization { [weak self] newStatus in
				if newStatus == .authorized {
					self?.presentImagePicker()
				} else {
					print(newStatus)
				}
			}
		default:
			print(photoAuthorizationStatus)
		}
		
		
	}
	
	func presentImagePicker() {
		let imagePickerController = UIImagePickerController()
		imagePickerController.sourceType = .photoLibrary
		imagePickerController.delegate = self
		present(imagePickerController, animated: true)
	}
}

extension CollageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	@objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let image = info[.originalImage] as? UIImage {
			selectedImageViewToAdd?.image = image
			selectedButtonToAddImage?.isHidden = true
		}
		dismiss(animated: true)
	}
}

extension CollageViewController: CollageView {
	
}


