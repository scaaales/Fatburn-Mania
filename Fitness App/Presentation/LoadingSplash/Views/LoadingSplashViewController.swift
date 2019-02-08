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
	
	@IBOutlet private weak var loader: UIActivityIndicatorView!
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		presenter.decideRouting()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.setNavigationBarHidden(true, animated: animated)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let tabBarController = segue.destination as? TabBarViewController,
			let navigationController = self.navigationController {
			tabBarController.presentedNavigationController = navigationController
		}
	}
	
}

extension LoadingSplashViewController: LoadingSplashView {
	func showMainScreen() {
		performSegue(withIdentifier: .presentMainTabBarSegueIdentifier, sender: nil)
	}
	
	func showLoginScreen() {
		performSegue(withIdentifier: .showLoginSegueIdentifier, sender: nil)
	}
	
	func showLoader() {
		loader.startAnimating()
	}
	
	func hideLoader() {
		loader.stopAnimating()
	}
	
	func showErrorPopup(with text: String, okHandler: @escaping () -> Void) {
		let alertController = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
		alertController.addAction(.init(title: "Ok", style: .cancel, handler: { _ in
			okHandler()
		}))
		present(alertController, animated: true)
	}
	
}


