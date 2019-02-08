//
//  LoginView.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

protocol LoginView: View {
	var email: String { get }
	var password: String { get }
	
	func disableUserInteraction()
	func enableUserInteraction()
	func showLoader()
	func hideLoader()
	
	func showErrors(_ errors: [LoginError])
	func showWrongPassword()
	func showErrorPopup(with text: String)
	func showTutorialScreen()
}
