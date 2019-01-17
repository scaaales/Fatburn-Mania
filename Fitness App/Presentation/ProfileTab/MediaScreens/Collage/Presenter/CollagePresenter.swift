//
//  CollagePresenter.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class CollagePresenter<V: CollageView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private let photoLibraryService: PhotoLibraryService
	
	required init(view: View) {
		self.view = view
		photoLibraryService = .init(viewControllerToPresentPicker: view.viewControllerToPresentPicker)
		if !photoLibraryService.authorized {
			photoLibraryService.authorize { result in
				print(result)
			}
		}
	}
	
	func getImageForLeftPart() {
		photoLibraryService.getImage { [weak self] image in
			if let image = image {
				self?.view.hideAddLeftPartButton()
				self?.view.setImageForLeftPart(image)
			}
		}
	}
	
	func getImageForRightPart() {
		photoLibraryService.getImage { [weak self] image in
			if let image = image {
				self?.view.hideAddRightPartButton()
				self?.view.setImageForRightPart(image)
			}
		}
	}
}
