//
//  ResetPasswordView.swift
//  Fitness App
//
//  Created by scales on 1/8/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

protocol ResetPasswordView: View {
	func disableUserInteraction()
	func enableUserInteraction()
	func showLoader()
	func hideLoader()
	func showSuccessSend()
	func showError()
}
