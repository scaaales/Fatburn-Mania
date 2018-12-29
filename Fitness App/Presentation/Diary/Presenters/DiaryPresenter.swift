//
//  DiaryPresenter.swift
//  Fitness App
//
//  Created by scales on 12/29/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import Foundation

class DiaryPresenter<V: DiaryView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private(set) var viewModel: TableViewModel!
	
	required init(view: View) {
		self.view = view
		viewModel = TableViewModel()
	}
	
	func getHealthInfo() {
		view.hideTableView()
		view.showLoader()
		
		HealthKitService.authorizeHealthKit { (authorized, error) in
			if !authorized {
				let baseMessage = "HealthKit Authorization Failed"
				if let error = error {
					print("\(baseMessage). Reason: \(error.localizedDescription)")
				} else {
					print(baseMessage)
				}
			}
		}
		
		getAllParameters { [weak self] in
			self?.view.showTableView()
			self?.view.hideLoader()
			self?.view.update()
		}
	}
	
	private func getAllParameters(completion: @escaping () -> Void) {
		let dispatchGroup = DispatchGroup()
		
		addTo(dispatchGroup: dispatchGroup,
			  execute: HealthKitService.getTodaySteps) { [weak self] steps in
				self?.viewModel.steps = steps
		}
		
		addTo(dispatchGroup: dispatchGroup,
			  execute: HealthKitService.getTodayCalories) { [weak self] calories in
				self?.viewModel.calories = calories
		}
		
		addTo(dispatchGroup: dispatchGroup,
			  execute: HealthKitService.getTodayProteins) { [weak self] proteins in
				self?.viewModel.proteins = proteins
		}
		
		addTo(dispatchGroup: dispatchGroup,
			  execute: HealthKitService.getTodayFats) { [weak self] fats in
				self?.viewModel.fats = fats
		}
		
		addTo(dispatchGroup: dispatchGroup,
			  execute: HealthKitService.getTodayCarbohydrates) { [weak self] carbohydrates in
				self?.viewModel.carbohydrates = carbohydrates
		}
		
		addTo(dispatchGroup: dispatchGroup,
			  execute: HealthKitService.getTodayWater) { [weak self] water in
				self?.viewModel.water = water
		}
		
		dispatchGroup.notify(queue: .main, execute: completion)
	}
	
	private func addTo<T>(dispatchGroup: DispatchGroup,
						  execute: (@escaping (T?) -> Void) -> Void,
						  completion: @escaping (T?) -> Void) {
		dispatchGroup.enter()
		execute { t in
			completion(t)
			dispatchGroup.leave()
		}
	}
	
}
