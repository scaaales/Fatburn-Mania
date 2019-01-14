//
//  CoinsHistoryPresenter.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class CoinsHistoryPresenter<V: CoinsHistoryView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: CoinsHistoryTableViewModel!
	
	required init(view: View) {
		self.view = view
	}
	
	func getHistory() {
		viewModel = .init()
		view.setTableViewDataSource(viewModel.dataSource)
		view.update()
	}
	
	func getMonthWithEaryForSection(_ section: Int) -> String {
		return viewModel.getMonthWithEaryForSection(section)
	}
}
