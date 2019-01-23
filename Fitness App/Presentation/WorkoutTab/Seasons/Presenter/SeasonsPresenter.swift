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
	
	required init(view: View) {
		self.view = view
	}
	
	func getSeasons() {
		let testSeasons = [
			Season(title: "Season 1", image: #imageLiteral(resourceName: "season1Test")),
			Season(title: "Season 2", image: #imageLiteral(resourceName: "season2Test")),
			Season(title: "Season 3", image: #imageLiteral(resourceName: "season3Test"))
		]
		dataSource = .init(items: testSeasons)
		view.setTableViewDataSource(dataSource)
		view.update()
	}
}
