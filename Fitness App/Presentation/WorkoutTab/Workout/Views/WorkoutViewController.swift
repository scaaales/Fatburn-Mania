//
//  WorkoutViewController.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class WorkoutViewController: RootViewController {
	var presenter: WorkoutPresenter<WorkoutViewController>!
	
	@IBOutlet private weak var roundedShadowView: BottomRoundedShadowView!
	@IBOutlet private weak var workoutSeasonsSegments: CustomSegmentedControl!
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var seasonsButton: UIBarButtonItem!
	
	lazy private var loader: BlurredLoader = {
		let loader = BlurredLoader()
		view.addSubview(loader)
		loader.centerInto(view: view)
		return loader
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		workoutSeasonsSegments.setOnSelectAction { [weak self] index in
			self?.presenter.getLessonsForWeek(at: index)
		}
		setupTableView()
		presenter.getCurrentSeason()
	}
	
	private func setupTableView() {
		tableView.backgroundColor = .clear
		tableView.makeResizable(cell: true)
		tableView.delegate = self
	}
	
	override func tryAgainTapped() {
		presenter.getCurrentSeason()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let lessonVC = segue.destination as? LessonViewController,
			let selectedIndex = tableView.indexPathForSelectedRow {
			tableView.deselectRow(at: selectedIndex, animated: true)
			
			let lesson = presenter.getLessonAt(index: selectedIndex.row)
			lessonVC.presenter.setLesson(lesson)
		} else if let seasonsVC = segue.destination as? SeasonsViewController {
			seasonsVC.workoutViewController = self
			seasonsVC.presenter.seasons = presenter.seasons
		}
	}
	
}

extension WorkoutViewController: WorkoutView {
	func hideTableView() {
		tableView.isHidden = true
	}
	
	func showTableView() {
		tableView.isHidden = false
	}
	
	func hideSegments() {
		roundedShadowView.isHidden = true
	}
	
	func showSegments() {
		roundedShadowView.isHidden = false
	}
	
	func disableUserInteraction() {
		view.isUserInteractionEnabled = false
	}
	
	func enableUserInteraction() {
		view.isUserInteractionEnabled = true
	}
	
	func disableSeasonsButton() {
		seasonsButton.isEnabled = false
	}
	
	func enableSeasonsButton() {
		seasonsButton.isEnabled = true
	}
	
	func showLoader() {
		loader.startAnimating()
	}
	
	func hideLoader() {
		loader.stopAnimating()
	}
	
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

