//
//  DiaryPresenter.swift
//  Fitness App
//
//  Created by scales on 12/29/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift

class DiaryPresenter<V: DiaryView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: DiaryTableViewModel!
	private let diaryApi: FitnessApi.Diary
	private let dispatchGroup = DispatchGroup()
	private var measurementsCache = [Date: Measurements?]()
	
	required init(view: View) {
		self.view = view
		
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else {
			fatalError("cannot find access token")
		}
		
		diaryApi = .init(token: token)
	}
	
	func getInitialHealthInfo() {
		viewModel = DiaryTableViewModel(leftBodyMeasurements: nil,
											 rightBodyMeasurements: nil,
											 leftDateString: Date().formattedStringWithTime,
											 rightDateString: Date().formattedStringWithTime)
		view.setTableViewDataSource(self.viewModel)
		
		getHealthInfo(on: .init())
	}
	
	func getHealthInfo(on date: Date) {
		viewModel.leftDateString = date.formattedStringWithBlankTime
		
		let calendar = Calendar.current
		let setToday = calendar.isDateInToday(date)
		
		if let cachedMeasurements = measurementsCache[date] { // load measurements from cache
			handleNewMeasurements(cachedMeasurements, setToday: setToday)
		} else { // load measurements from API
			view.disableUserInteraction()
			view.hideTableView()
			view.showLoader()
			getMeasurements(on: date, setToday: setToday)
		}
		
		// get from healthkit
		HealthKitService.authorizeHealthKit { [weak self] (authorized, error) in
			if !authorized {
				let baseMessage = "HealthKit Authorization Failed"
				if let error = error {
					print("\(baseMessage). Reason: \(error.localizedDescription)")
				} else {
					print(baseMessage)
				}
			} else {
				self?.getAllFields(on: date)
			}
		}
		
		dispatchGroup.notify(queue: .main) { [weak self] in
			self?.view.showTableView()
			self?.view.update()
		}
		
	}
	
	private func getMeasurements(on date: Date, setToday: Bool) {
		dispatchGroup.enter()
		diaryApi.getMeasurements(at: date, limit: 1, onComplete: { [weak self] in
			self?.view.hideLoader()
			self?.view.enableUserInteraction()
			}, onSuccess: { [weak self] measurements in
				guard let self = self else { return }
				self.handleNewMeasurements(measurements.last, setToday: setToday)
				self.measurementsCache[date] = measurements.last
				self.dispatchGroup.leave()
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
	
	private func handleNewMeasurements(_ measurements: Measurements?, setToday: Bool) {
		viewModel.leftBodyMeasurements = measurements
		if let leftDateString = measurements?.date?.formattedStringWithTime {
			viewModel.leftDateString = leftDateString
			if setToday {
				viewModel.rightDateString = leftDateString
				viewModel.rightBodyMeasurements = measurements
			}
		} else {
			if setToday {
				viewModel.rightDateString = Date().formattedStringWithTime
			}
		}
	}
	
	private func getAllFields(on date: Date) {
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
