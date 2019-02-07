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
		UserDefaults.standard.set(true, forKey: .userDefaultsKeyIsLogginedIn)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.setNavigationBarHidden(true, animated: animated)
		super.viewWillAppear(animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
		super.viewWillDisappear(animated)
	}
	
}

extension LoginSplashViewController: LoginSplashView {
	
	
}
