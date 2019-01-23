//
//  WorkoutViewController.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {
	var presenter: WorkoutPresenter<WorkoutViewController>!
	
	@IBOutlet private weak var workoutSeasonsSegments: CustomSegmentedControl!
	@IBOutlet private weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		workoutSeasonsSegments.setOnSelectAction { [weak self] index in
			self?.presenter.getLessonsForSeason(at: index)
		}
		setupTableView()
		presenter.getSeasons()
	}
	
	private func setupTableView() {
		tableView.backgroundColor = .clear
		tableView.delegate = self
	}
	
}

extension WorkoutViewController: WorkoutView {
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
	func update() {
		tableView.reloadData()
	}
	
	func setSegments(titles: [String]) {
		workoutSeasonsSegments.setItemsTitles(titles)
	}
}

extension WorkoutViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 25
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}
}

