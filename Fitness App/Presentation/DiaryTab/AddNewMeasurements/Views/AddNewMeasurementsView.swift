//
//  AddNewMeasurementsView.swift
//  Fitness App
//
//  Created by scales on 2/13/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

protocol AddNewMeasurementsView: View, NetworkingView {
	var chest: String { get }
	var waist: String { get }
	var thighs: String { get }
	var hip: String { get }
	var weight: String { get }
	
	func setDate(_ date: Date)
	func setDefaultMeasurements(_ measurements: Measurements)
	func showCoinsAddedScreen(with coinsNumber: Int)
	func showErrorPopup(with errorText: String)
	func closeItself()
}
