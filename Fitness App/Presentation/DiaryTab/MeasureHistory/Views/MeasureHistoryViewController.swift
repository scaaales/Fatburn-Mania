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
	
	lazy private var blurredLoader: BlurredLoader = {
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
		tableView.delegate = self
		tableView.backgroundColor = .white
	}
	
}

extension MeasureHistoryViewController: MeasureHistoryView {
	func disableUserInteraction() {
		view.isUserInteractionEnabled = false
	}
	
	func enableUserInteraction() {
		view.isUserInteractionEnabled = true
	}
	
	func showLoader() {
		blurredLoader.startAnimating()
	}
	
	func hideLoader() {
		blurredLoader.stopAnimating()
	}
	
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
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if indexPath.row == presenter.currentNumberOfItems - 1 {
			presenter.getHistory()
		}
	}
}

