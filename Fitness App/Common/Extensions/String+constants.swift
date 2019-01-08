//
//  String+constants.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

// MARK: - UserDefault
extension String {
	static var userDefaultKeyIsLogginedIn: String { return "isLogginedIn" }
	static var userDefaultsKeyIsTutorialShown: String { return "isTutorialShown" }
}

// MARK: - SegueIdentifiers
extension String {
	static var presentTutorialSegueIdentifier: String { return "presentTutorial" }
	static var presentLoginSegueIdentifier: String { return "presentLogin" }
}

// MARK: - Text Constants
extension String {
	static var wrongPasswordConstant: String { return "Wrong password" }
	static var wrongEmailConstant: String { return "Wrong E-mail" }
	static var forgotPasswordConstant: String { return "Forgot your password?" }
	static var emailWasSentConstant: String { return "E-mail with instructions on how to reset your password was sent" }
	static var closeConstant: String { return "Close" }
}

