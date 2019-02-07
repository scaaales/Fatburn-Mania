//
//  LoadingSplashViewController.swift
//  Fitness App
//
//  Created by scales on 2/7/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class LoadingSplashViewController: UIViewController {
	var presenter: LoadingSplashPresenter<LoadingSplashViewController>!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			self.performSegue(withIdentifier: .showLoginSegueIdentifier, sender: nil)
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.setNavigationBarHidden(true, animated: animated)
		super.viewWillAppear(animated)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let tabBarController = segue.destination as? TabBarViewController,
			let navigationController = self.navigationController {
			tabBarController.presentedNavigationController = navigationController
		}
	}
	
}

extension LoadingSplashViewController: LoadingSplashView {
	
}


