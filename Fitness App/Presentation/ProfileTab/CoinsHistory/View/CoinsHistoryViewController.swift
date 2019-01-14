//
//  CoinsHistoryViewController.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CoinsHistoryViewController: UIViewController {
	var presenter: CoinsHistoryPresenter<CoinsHistoryViewController>!
	
	@IBOutlet private weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupTableView()
		presenter.getHistory()
	}
	
	private func setupTableView() {
		tableView.delegate = self
		
		tableView.makeResizable(header: false, footer: false)
	}
	
}

extension CoinsHistoryViewController: CoinsHistoryView {
	func update() {
		tableView.reloadData()
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
}

extension CoinsHistoryViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let title = presenter.getMonthWithEaryForSection(section).lowercased()
		let item = CellsConfigurator<CoinsHistoryHeader, String>(item: title)
		guard let header = tableView.dequeueReusableCell(withIdentifier: item.reuseId) else { return nil }
		item.configure(cell: header)
		return header
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}

}
