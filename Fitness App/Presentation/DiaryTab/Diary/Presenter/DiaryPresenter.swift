//
//  DiaryPresenter.swift
//  Fitness App
//
//  Created by scales on 12/29/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import Foundation

class DiaryPresenter<V: DiaryView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private(set) var viewModel: DiaryTableViewModel
	
	required init(view: View) {
		self.view = view
		viewModel = DiaryTableViewModel()
	}
	
	func getInitialHealthInfo() {
		view.hideTableView()
		getHealthInfo(on: .init())
	}
	
	func getHealthInfo(on date: Date) {
		view.showLoader()
		
		HealthKitService.authorizeHealthKit { [weak self] (authorized, error) in
			if !authorized {
				let baseMessage = "HealthKit Authorization Failed"
				if let error = error {
					print("\(baseMessage). Reason: \(error.localizedDescription)")
				} else {
					print(baseMessage)
				}
			} else {
				self?.getAllFields(on: date) {
					self?.view.showTableView()
					self?.view.hideLoader()
					self?.view.update()
				}
			}
		}
		
	}
	
	private func getAllFields(on date: Date, completion: @escaping () -> Void) {
		let dispatchGroup = DispatchGroup()
		
		addTo(dispatchGroup: dispatchGroup,
			  execute: HealthKitService.getSteps, date: date) { [weak self] steps in
				self?.viewModel.steps = steps
		}
		
		addTo(dispatchGroup: dispatchGroup,
			  execute: HealthKitService.getCalories, date: date) { [weak self] calories in
				self?.viewModel.calories = calories
		}
		
		addTo(dispatchGroup: dispatchGroup,
			  execute: HealthKitService.getProteins, date: date) { [weak self] proteins in
				self?.viewModel.proteins = proteins
		}
		
		addTo(dispatchGroup: dispatchGroup,
			  execute: HealthKitService.getFats, date: date) { [weak self] fats in
				self?.viewModel.fats = fats
		}
		
		addTo(dispatchGroup: dispatchGroup,
			  execute: HealthKitService.getCarbohydrates, date: date) { [weak self] carbohydrates in
				self?.viewModel.carbohydrates = carbohydrates
		}
		
		addTo(dispatchGroup: dispatchGroup,
			  execute: HealthKitService.getWater, date: date) { [weak self] water in
				self?.viewModel.water = water
		}
		
		dispatchGroup.notify(queue: .main, execute: completion)
	}
	
	private func addTo<T>(dispatchGroup: DispatchGroup,
						  execute: (Date ,@escaping (T?) -> Void) -> Void,
						  date: Date,
						  completion: @escaping (T?) -> Void) {
		dispatchGroup.enter()
		execute(date) { t in
			completion(t)
			dispatchGroup.leave()
		}
	}
	
}
