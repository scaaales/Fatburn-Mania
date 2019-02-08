//
//  NetworkingView.swift
//  Fitness App
//
//  Created by scales on 2/8/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

protocol NetworkingView {
	func disableUserInteraction()
	func enableUserInteraction()
	func showLoader()
	func hideLoader()
}
