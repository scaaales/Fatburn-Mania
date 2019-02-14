//
//  AddNewMeasurementsPresenter.swift
//  Fitness App
//
//  Created by scales on 2/13/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class AddNewMeasurementsPresenter<V: AddNewMeasurementsView>: Presenter {
	typealias View = V
	
	weak var view: View!
	
	required init(view: View) {
		self.view = view
	}
	
	func getDefaultMeasurements() {
		if Bool.random() {
			view.setDefaultMeasurements(.init(chest: 100,
											  waist: 60,
											  thighs: 90,
											  hip: 25,
											  weight: 60))
		}
	}
	
	func addNewMeasurements() {
		if isFieldsValid() {
			view.showCoinsAddedScreen(with: 10)
		} else {
			let errorText = "Please ensure all measurements are filled"
			view.showErrorPopup(with: errorText)
		}
	}
	
	func getDate() {
		view.setDate(.init())
	}
	
	private func isFieldsValid() -> Bool {
		let fields = [view.chest, view.hip, view.thighs, view.waist, view.weight]
		return !fields.contains(where: { $0.isEmpty })
	}
}
