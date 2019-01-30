//
//  MainNavigationController.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class MainNavigationController: LoginNavigationController {
	
	override func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
		super.navigationController(navigationController, willShow: viewController, animated: animated)
		addRightButtons(to: viewController)
	}
	
	private func addRightButtons(to viewController: UIViewController) {
		let shopButton = UIBarButtonItem(image: #imageLiteral(resourceName: "shoppingCart"), style: .plain, target: self, action: #selector(presentShop))
		let notificationsButton = UIBarButtonItem(image: #imageLiteral(resourceName: "notification"), style: .plain, target: self, action: #selector(presentNotifications))
		
		viewController.navigationItem.setRightBarButtonItems([notificationsButton, shopButton], animated: false)
	}
	
	@objc private func presentShop() {
		guard let storeVC = UIStoryboard.storeStack.instantiateInitialViewController() as? StoreViewController else { return }
		storeVC.isPresentedModal = true
		let navigationController = LoginNavigationController(rootViewController: storeVC)
		self.present(navigationController, animated: true)
	}
	
	@objc private func presentNotifications() {
		guard let notificationsVC = UIStoryboard.notifications.instantiateInitialViewController() else { return }
		self.present(notificationsVC, animated: true)
	}
	
}
