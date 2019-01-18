//
//  PhotoLibraryService.swift
//  Fitness App
//
//  Created by scales on 1/17/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit
import Photos

class PhotoLibraryService: NSObject {
	
	private var getImageCompletion: ((UIImage?) -> Void)?
	private weak var viewControllerToPresentPicker: UIViewController!
	var authorized: Bool {
		return PHPhotoLibrary.authorizationStatus() == .authorized
	}
	
	init(viewControllerToPresentPicker: UIViewController) {
		self.viewControllerToPresentPicker = viewControllerToPresentPicker
	}
	
	func authorize(completion: @escaping (_ success: Bool) -> Void) {
		let available = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
		guard available else {
			completion(false)
			return
		}
	
		let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
		switch photoAuthorizationStatus {
		case .authorized:
			completion(true)
		case .notDetermined:
			PHPhotoLibrary.requestAuthorization { newStatus in
				if newStatus == .authorized {
					completion(true)
				} else {
					print(newStatus)
					completion(false)
				}
			}
		default:
			print(photoAuthorizationStatus)
			completion(false)
		}
	}
	
	func getImage(completion: @escaping (UIImage?) -> Void) {
		getImageCompletion = completion
		
		let imagePickerController = UIImagePickerController()
		imagePickerController.sourceType = .photoLibrary
		imagePickerController.delegate = self
		viewControllerToPresentPicker.present(imagePickerController, animated: true)
	}
}

extension PhotoLibraryService: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	@objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		getImageCompletion?(info[.originalImage] as? UIImage)
		viewControllerToPresentPicker.dismiss(animated: true)
	}
}
