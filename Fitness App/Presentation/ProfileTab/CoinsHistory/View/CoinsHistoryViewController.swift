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
	
	lazy private var loader: BlurredLoader = {
		let loader = BlurredLoader()
		view.addSubview(loader)
		loader.centerInto(view: view)
		return loader
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupTableView()
		presenter.getHistory()
	}
	
	private func setupTableView() {
		tableView.makeResizable(header: false, footer: false)
	}
	
}

extension CoinsHistoryViewController: CoinsHistoryView {
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
		tableView.delegate = self
	}
	
}

extension CoinsHistoryViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let title = presenter.getMonthWithEaryForSection(section)?.lowercased() else { return nil }
		let item = CellsConfigurator<CoinsHistoryHeader, String>(item: title)
		guard let header = tableView.dequeueReusableCell(withIdentifier: item.reuseId) else { return nil }
		item.configure(cell: header)
		return header
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}

}
