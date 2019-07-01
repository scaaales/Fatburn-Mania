//
//  LoginSplashViewController.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class LoginSplashViewController: UIViewController {
	var presenter: LoginSplashPresenter<LoginSplashViewController>!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = " "
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.setNavigationBarHidden(true, animated: animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
}

extension LoginSplashViewController: LoginSplashView {
	
	
}
