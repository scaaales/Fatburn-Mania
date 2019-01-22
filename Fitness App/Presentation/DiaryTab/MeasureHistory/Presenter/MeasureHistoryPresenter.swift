//
//  MeasureHistoryPresenter.swift
//  Fitness App
//
//  Created by scales on 1/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class MeasureHistoryPresenter<V: MeasureHistoryView>: Presenter {
	typealias View = V
	
	weak var view: View!
	
	required init(view: View) {
		self.view = view
	}
}
