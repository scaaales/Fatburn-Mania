//
//  NotificationsViewController.swift
//  Fitness App
//
//  Created by scales on 1/29/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {
	var presenter: NotificationsPresenter<NotificationsViewController>!
	
	@IBOutlet private weak var navBar: UINavigationBar!
	@IBOutlet private weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navBar.shadowImage = UIImage()
		tableView.delegate = self
		presenter.getNotifications()
	}
	
	@IBAction private func close() {
		dismiss(animated: true)
	}
	
}

extension NotificationsViewController: NotificationsView {
	func update() {
		tableView.reloadData()
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
}

extension NotificationsViewController: UITableViewDelegate {
	
}


