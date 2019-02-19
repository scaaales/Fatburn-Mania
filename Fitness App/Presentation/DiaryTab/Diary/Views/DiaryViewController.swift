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
	}

	private func setupTableView() {
		tableView.delegate = self
		
		tableView.makeResizable()
		
		tableView.backgroundColor = .white
	}
}

extension DiaryViewController: DiaryView {
	func disableUserInteraction() {
		view.isUserInteractionEnabled = false
	}
	
	func enableUserInteraction() {
		view.isUserInteractionEnabled = true
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
	func update() {
		let contentOffset = tableView.contentOffset
		tableView.reloadData()
		tableView.layoutIfNeeded()
		tableView.layer.removeAllAnimations()
		tableView.setContentOffset(contentOffset, animated: false)
		
	}
	
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
	
}

extension DiaryViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
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
