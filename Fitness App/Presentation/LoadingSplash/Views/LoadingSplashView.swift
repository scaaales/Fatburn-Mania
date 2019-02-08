//
//  LoadingSplashView.swift
//  Fitness App
//
//  Created by scales on 2/7/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

protocol LoadingSplashView: View {
	func showMainScreen()
	func showLoginScreen()
	func showLoader()
	func hideLoader()
	func showErrorPopup(with text: String, okHandler: @escaping () -> Void)
}
