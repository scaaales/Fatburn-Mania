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
	
	lazy private var loader: BlurredLoader = {
		let loader = BlurredLoader()
		view.addSubview(loader)
		loader.centerInto(view: view)
		return loader
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navBar.shadowImage = UIImage()
		setupTableView()
		presenter.getNotifications()
	}
	
	private func setupTableView() {
		tableView.delegate = self
		tableView.backgroundColor = .white
		tableView.makeResizable(header: false, footer: false)
	}
	
	@IBAction private func close() {
		dismiss(animated: true)
	}
	
}

extension NotificationsViewController: NotificationsView {
	func disableUserInteraction() {
		view.isUserInteractionEnabled = false
	}
	
	func enableUserInteraction() {
		view.isUserInteractionEnabled = true
	}
	
	func showLoader() {
		loader.startAnimating()
	}
	
	func hideLoader() {
		loader.stopAnimating()
	}
	
	func update() {
		tableView.reloadData()
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
}

extension NotificationsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 20
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 20
	}
}


