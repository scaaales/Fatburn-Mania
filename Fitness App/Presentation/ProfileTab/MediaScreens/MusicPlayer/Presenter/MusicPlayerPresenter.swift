//
//  MusicPlayerPresenter.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class MusicPlayerPresenter<V: MusicPlayerView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: SongsTableViewModel!
	
	required init(view: View) {
		self.view = view
	}
	
	func getSongs() {
		viewModel = .init()
		view.setTableViewDataSource(viewModel.dataSource)
		view.update()
	}
}
