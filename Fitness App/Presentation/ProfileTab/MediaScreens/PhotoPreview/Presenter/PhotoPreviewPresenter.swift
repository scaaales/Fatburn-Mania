//
//  PhotoPreviewPresenter.swift
//  Fitness App
//
//  Created by scales on 2/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol PhotoConfirmedDelegate: class {
	func photoConfirmed()
}

class PhotoPreviewPresenter<V: PhotoPreviewView>: Presenter {
	typealias View = V
	
	weak var view: View!
	
	weak var delegate: PhotoConfirmedDelegate?
	
	required init(view: View) {
		self.view = view
	}
	
	func savePhoto() {
		view.closeItself { [weak self] in
			self?.delegate?.photoConfirmed()
		}
	}
}
