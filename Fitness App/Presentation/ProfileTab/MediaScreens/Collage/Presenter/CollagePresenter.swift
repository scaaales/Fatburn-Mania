//
//  CollagePresenter.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CollagePresenter<V: CollageView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private let photoLibraryService: PhotoLibraryService
	
	required init(view: View) {
		self.view = view
		photoLibraryService = .init(viewControllerToPresentPicker: view.viewControllerToPresentPicker)
	}
	
	func getImageForLeftPart() {
		authorizeIfNeeded { [weak self] in
			self?.photoLibraryService.getImage { image in
				if let image = image {
					self?.view.hideAddLeftPartButton()
					self?.view.setImageForLeftPart(image)
				}
			}
		}
		
	}
	
	func getImageForRightPart() {
		authorizeIfNeeded { [weak self] in
			self?.photoLibraryService.getImage { image in
				if let image = image {
					self?.view.hideAddRightPartButton()
					self?.view.setImageForRightPart(image)
				}
			}
		}
	}
	
	func saveImages(leftImage: UIImage?, rightImage: UIImage?) {
		if let leftImage = leftImage, let rightImage = rightImage {
			// some saving logic
			view.closeItself()
		} else {
			view.presentErrorSaving()
		}
	}
	
	private func authorizeIfNeeded(successCompletion: @escaping () -> Void) {
		if photoLibraryService.authorized {
			successCompletion()
		} else {
			photoLibraryService.authorize { success in
				if success {
					successCompletion()
				}
			}
		}
	}
}
