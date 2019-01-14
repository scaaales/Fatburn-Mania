//
//  StorePresenter.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class StorePresenter<V: StoreView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: StoreProductsTableViewModel!
	
	required init(view: View) {
		self.view = view
	}
	
	func getProducts() {
		viewModel = .init()
		view.setTableViewDataSource(viewModel.dataSource)
		view.update()
	}
}
