//
//  StoreViewController.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {
	var presenter: StorePresenter<StoreViewController>!
	
	@IBOutlet private weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		presenter.getProducts()
	}
	
	private func setupTableView() {
		tableView.makeResizable()
		tableView.backgroundColor = .white
	}
	
	
}

extension StoreViewController: StoreView {
	func update() {
		tableView.reloadData()
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
}


