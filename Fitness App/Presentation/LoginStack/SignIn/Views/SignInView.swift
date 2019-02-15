//
//  SignInView.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

protocol SignInView: View, NetworkingView, PopupShowable {
	var name: String { get }
	var email: String { get }
	var phone: String { get }
	var password: String { get }
	
	func showErrors(_ errors: [SignInError])
	func showSuccess(title: String, completion: @escaping () -> Void)
	func pop() 
}
