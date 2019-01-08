//
//  LoginView.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

protocol LoginView: View {
	func disableUserInteraction()
	func enableUserInteraction()
	func showLoader()
	func hideLoader()
	func presentTutorialScreen()
	func showError()
}
