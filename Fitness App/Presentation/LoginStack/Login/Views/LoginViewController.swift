//
//  LoginViewController.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	var presenter: LoginPresenter<LoginViewController>!
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
}

extension LoginViewController: LoginView {
	
}
