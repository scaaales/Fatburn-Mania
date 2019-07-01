//
//  AddNewMeasurementsPresenter.swift
//  Fitness App
//
//  Created by scales on 2/13/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift

class AddNewMeasurementsPresenter<V: AddNewMeasurementsView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private let diaryApi: FitnessApi.Diary
	private let rewardApi: FitnessApi.Reward
	private let savingDate = Date()
	private(set) var addedMeasurements: Measurements?
	
	required init(view: View) {
		self.view = view
		
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else {
			fatalError("cannot find access token")
		}
		
		diaryApi = .init(token: token)
		rewardApi = .init(token: token)
	}
	
	func getDefaultMeasurements() {

	}
	
	func addNewMeasurements() {
		let intFields = [view.chest, view.waist, view.thighs, view.hip].compactMap({ Int($0) })
		let weightString = view.weight
		if intFields.count == 4,
			let weightDouble = Double(weightString), isWeightValid(weightString) {
			let dateFormatter = DateFormatter()
			dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

			dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

			let dateString = dateFormatter.string(from: savingDate)

			let measurements = Measurements(chest: intFields[0],
											waist: intFields[1],
											thighs: intFields[2],
											hip: intFields[3],
											weight: weightDouble,
											dateString: dateString)
			makeAddMeasurementsRequest(measurements)
		} else {
			let errorText = "Please ensure all measurements are filled"
			view.showErrorPopup(with: errorText)
		}
	}
	
	private func makeAddMeasurementsRequest(_ measurements: Measurements) {
		view.disableUserInteraction()
		view.showLoader()
		
		diaryApi.addMeasureemts(measurements, onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] in
			guard let self = self else { return }
			self.addedMeasurements = measurements
			HealthKitService.saveWaistValue(measurements.waist.doubleValue, on: self.savingDate)
			HealthKitService.saveWeightValue(measurements.weight, on: self.savingDate)
			self.makeGetRewardRequest()
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
	
	private func makeGetRewardRequest() {
		view.disableUserInteraction()
		view.showLoader()
		
		rewardApi.getMeasurementsReward(onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] amount in
			if let amount = amount {
				NotificationCenter.default.post(name: .coinsAdded,
												object: self,
												userInfo: ["value": amount])
				self?.view.showCoinsAddedScreen(with: amount)
			} else {
				self?.view.closeItself()
			}
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
	
	private func isWeightValid(_ weightString: String) -> Bool {
		if weightString.contains(".") {
			let weightSubstrings = weightString.split(separator: ".")
			if weightSubstrings.count != 2 {
				return false
			}
			let weightLeftPart = weightSubstrings[0]
			let weightRightPart = weightSubstrings[1]
			if weightRightPart.isEmpty {
				return weightLeftPart.count <= 3
			} else {
				return weightRightPart.count <= 2 && weightLeftPart.count <= 3
			}
		} else {
			return weightString.count <= 3
		}
	}
	
	func getDate() {
		view.setDate(savingDate)
	}
	
}
