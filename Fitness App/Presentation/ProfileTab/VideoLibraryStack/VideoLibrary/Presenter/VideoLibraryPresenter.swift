//
//  VideoLibraryPresenter.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class VideoLibraryPresenter<V: VideoLibraryView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: VideoLibraryCollectionViewModel!
	
	required init(view: View) {
		self.view = view
	}
	
	func getCourses() {
		viewModel = .init()
		view.setCollectionViewDataSource(viewModel.dataSource)
		view.update()
	}
	
	func getTitleAtIndex(_ index: Int) -> String {
		return viewModel.getTitleAtIndex(index)
	}
}

