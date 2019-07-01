//
//  SeasonsPresenter.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class SeasonsPresenter<V: SeasonsView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var dataSource: BasicTableViewDataSource<SeasonCell, Season>!
	var seasons: [Season]!
	
	required init(view: View) {
		self.view = view
	}
	
	func getSeasons() {
		dataSource = .init(items: seasons)
		view.setTableViewDataSource(dataSource)
		view.update()
	}
	
}
