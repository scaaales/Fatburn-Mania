//
//  PhotoPreviewPresenter.swift
//  Fitness App
//
//  Created by scales on 2/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class PhotoPreviewPresenter<V: PhotoPreviewView>: Presenter {
	typealias View = V
	
	weak var view: View!
	
	required init(view: View) {
		self.view = view
	}
	
	func savePhoto() {
		
	}
}
