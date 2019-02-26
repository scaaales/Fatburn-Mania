//
//  MainNavigationController.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class MainNavigationController: LoginNavigationController {
	
	private lazy var notificationView: UIView! = {
		let view = UIView(frame: .init(x: 10, y: 0, width: 8, height: 8))
		view.layer.borderColor = UIColor.clear.cgColor
		view.layer.cornerRadius = view.bounds.size.height / 2
		view.layer.masksToBounds = true
		view.backgroundColor = .redErrorColor
		
		notificationButton.addSubview(view)
		
		return view
	}()
	
	private lazy var notificationButton: UIButton = {
		let button = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 21))
		button.setBackgroundImage(#imageLiteral(resourceName: "notificationBell"), for: .normal)
		button.addTarget(self, action: #selector(presentNotifications), for: .touchUpInside)
		
		return button
	}()
	
	private lazy var storeButton: UIButton = {
		let button = UIButton(frame: CGRect(x: 0, y: 0, width: 23, height: 21))
		button.setBackgroundImage(#imageLiteral(resourceName: "shoppingCart"), for: .normal)
		button.addTarget(self, action: #selector(presentShop), for: .touchUpInside)
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		NotificationCenter.default.addObserver(self,
											   selector: #selector(handleNotificationsCountChange(_:)),
											   name: .notificationsCountChanged,
											   object: nil)
	}
	
	override func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
		super.navigationController(navigationController, willShow: viewController, animated: animated)
		addRightButtons(to: viewController)
	}
	
	private func addRightButtons(to viewController: UIViewController) {
		let shopButton = UIBarButtonItem(customView: storeButton)
		let notificationsButton = UIBarButtonItem(customView: notificationButton)
		if let count = AppDelegate.shared.pushNotificationService?.unreadNotificationsCount {
			if count > 0 {
				notificationView.isHidden = false
			} else {
				notificationView.isHidden = true
			}
		}
		
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
	
	@objc private func handleNotificationsCountChange(_ notification: Notification) {
		if let userInfo = notification.userInfo as? [String: Int],
			let value = userInfo["value"] {
			if value > 0 {
				notificationView.isHidden = false
			} else {
				notificationView.isHidden = true
			}
		}
	}
	
}
