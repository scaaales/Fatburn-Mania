//
//  MeasureHistoryViewController.swift
//  Fitness App
//
//  Created by scales on 1/22/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class MeasureHistoryViewController: UIViewController {
	var presenter: MeasureHistoryPresenter<MeasureHistoryViewController>!
	
	@IBOutlet private weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupTableView()
		presenter.getHistory()
	}
	
	private func setupTableView() {
		tableView.delegate = self
		tableView.backgroundColor = .white
	}
	
}

extension MeasureHistoryViewController: MeasureHistoryView {
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
	func update() {
		tableView.reloadData()
	}
	
}

extension MeasureHistoryViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 11
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}
}

