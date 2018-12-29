//
//  DiaryViewController.swift
//  Fitness App
//
//  Created by scales on 12/14/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController {
	var presenter: DiaryPresenter<DiaryViewController>!
	
	@IBOutlet private weak var calendarView: CalendarView!
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var blurredLoader: BlurredLoader!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		calendarView.configure()
		setupTableView()
		setupNavigationBar()
		presenter.getHealthInfo()
	}
	
	private func setupNavigationBar() {
		navigationController?.navigationBar.shadowImage = UIImage()
	}

	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = presenter.viewModel
		
		tableView.estimatedSectionHeaderHeight = 1
		tableView.sectionHeaderHeight = UITableView.automaticDimension
		
		tableView.estimatedRowHeight = 1
		tableView.rowHeight = UITableView.automaticDimension
		
		tableView.estimatedSectionFooterHeight = 1
		tableView.sectionFooterHeight = UITableView.automaticDimension
		
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
			let header = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId) {
			item.configure(cell: header)
			
			return header.contentView
		}
		
		return nil
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		if let item = presenter.viewModel.footerFor(index: section),
			let footer = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId) {
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
