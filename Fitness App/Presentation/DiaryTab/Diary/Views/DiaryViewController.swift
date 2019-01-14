//
//  DiaryViewController.swift
//  Fitness App
//
//  Created by scales on 12/14/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController {
	var presenter: DiaryPresenter<DiaryViewController>!
	
	@IBOutlet private weak var calendarView: CalendarView!
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var blurredLoader: BlurredLoader!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		calendarView.configure(calendarViewDateDelegate: self)
		setupTableView()
		presenter.getInitialHealthInfo()
		UserDefaults.standard.set(false, forKey: .userDefaultKeyIsLogginedIn)
	}

	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = presenter.viewModel
		
		tableView.makeResizable()
		
		tableView.backgroundColor = .white
	}
}

extension DiaryViewController: DiaryView {
	func showLoader() {
		blurredLoader.startAnimating()
	}
	
	func hideLoader() {
		blurredLoader.stopAnimating()
	}
	
	func showTableView() {
		tableView.isHidden = false
	}
	
	func hideTableView() {
		tableView.isHidden = true
	}
	
	func update() {
		tableView.reloadData()
	}
}

extension DiaryViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if let item = presenter.viewModel.headerFor(index: section),
			let header = tableView.dequeueReusableCell(withIdentifier: item.reuseId) {
			item.configure(cell: header)
			
			return header.contentView
		}
		
		return nil
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		if let item = presenter.viewModel.footerFor(index: section),
			let footer = tableView.dequeueReusableCell(withIdentifier: item.reuseId) {
			item.configure(cell: footer)
			
			return footer.contentView
		}
		
		return nil
	}
}

// MARK: - Scroll view delegate
extension DiaryViewController {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let contentOffsetY = scrollView.contentOffset.y
		if contentOffsetY > 10 {
			calendarView.closeAnimated()
		} else {
			calendarView.openAnimated()
		}
	}
}

extension DiaryViewController: CalendarViewDateDelegate {
	func didSelectDate(_ date: Date) {
		presenter.getHealthInfo(on: date)
	}
}
