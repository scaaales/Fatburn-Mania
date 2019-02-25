//
//  SeasonsViewController.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class SeasonsViewController: UIViewController {
	var presenter: SeasonsPresenter<SeasonsViewController>!
	
	@IBOutlet private weak var tableView: UITableView!
	var workoutViewController: WorkoutViewController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupTableView()
		presenter.getSeasons()
	}
	
	private func setupTableView() {
		tableView.backgroundColor = .white
		tableView.delegate = self
	}
	
}

extension SeasonsViewController: SeasonsView {
	func update() {
		tableView.reloadData()
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
}

extension SeasonsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 5
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		workoutViewController.presenter.selectedSeasonID = presenter.seasons[indexPath.row].id
		navigationController?.popViewController(animated: true)
	}
}

