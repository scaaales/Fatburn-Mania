//
//  SignInViewController.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
	var presenter: SignInPresenter<SignInViewController>!
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension SignInViewController: SignInView {
	
}
