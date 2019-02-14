//
//  PhotoPreviewPresenter.swift
//  Fitness App
//
//  Created by scales on 2/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import Photos

class PhotoPreviewPresenter<V: PhotoPreviewView>: Presenter {
	typealias View = V
	
	weak var view: View!
	
	required init(view: View) {
		self.view = view
	}
	
	func savePhoto() {
		PHPhotoLibrary.shared().performChanges({ [weak self] in
			guard let image = self?.view.photo else { return }
			PHAssetChangeRequest.creationRequestForAsset(from: image)
		}) { [weak self] success, error in
			if success {
				self?.view.closeItself()
			} else if let error = error {
				print(error)
			}
		}
	}
}
