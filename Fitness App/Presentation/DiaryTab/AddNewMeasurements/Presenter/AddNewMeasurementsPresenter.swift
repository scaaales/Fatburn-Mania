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
	private let savingDate = Date()
	
	required init(view: View) {
		self.view = view
		
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else {
			fatalError("cannot find access token")
		}
		
		diaryApi = .init(token: token)
	}
	
	func getDefaultMeasurements() {

	}
	
	func addNewMeasurements() {
		let intFields = [view.chest, view.waist, view.thighs, view.hip].compactMap({ Int($0) })
		let weightString = view.weight
		if intFields.count == 4,
			let weightDouble = Double(weightString), isWeightValid(weightString) {
			let measurements = Measurements(chest: intFields[0],
											waist: intFields[1],
											thighs: intFields[2],
											hip: intFields[3],
											weight: weightDouble)
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
			HealthKitService.saveWaistValue(measurements.waist.doubleValue, on: self.savingDate)
			HealthKitService.saveWeightValue(measurements.weight, on: self.savingDate)
			// TODO: Handler result later
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
