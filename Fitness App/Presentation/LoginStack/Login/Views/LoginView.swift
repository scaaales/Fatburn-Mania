//
//  LoginView.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

protocol LoginView: View, NetworkingView, ErrorShowable {
	var email: String { get }
	var password: String { get }
	
	func showErrors(_ errors: [LoginError])
	func showWrongPassword()
	func showTutorialScreen()
}
