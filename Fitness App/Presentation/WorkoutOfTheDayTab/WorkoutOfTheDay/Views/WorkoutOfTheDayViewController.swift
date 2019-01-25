//
//  WorkoutOfTheDayViewController.swift
//  Fitness App
//
//  Created by scales on 1/24/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class WorkoutOfTheDayViewController: UIViewController {
	var presenter: WorkoutOfTheDayPresenter<WorkoutOfTheDayViewController>!
	
	@IBOutlet private weak var sponsorImageView: UIImageView!
	@IBOutlet private weak var previewImageView: UIImageView!
	
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var rewardAndDurationLabel: UILabel!
	@IBOutlet private weak var descriptionLabel: UILabel!
	
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var tableViewHeight: NSLayoutConstraint!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		presenter.getWorkoutOfTheDay()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		tableViewHeight.constant = tableView.contentSize.height
	}
	
}

extension WorkoutOfTheDayViewController: WorkoutOfTheDayView {
	func setLessonName(_ name: String, reward: Int, duration: TimeInterval, description: String) {
		nameLabel.text = name
		rewardAndDurationLabel.text = "\(reward) coins - \(duration.stringMinutesOnly) minutes"
		descriptionLabel.text = description
	}
	
	func setLessonSponsorImage(_ sponsorImage: UIImage, previewImage: UIImage) {
		sponsorImageView.image = sponsorImage
		previewImageView.image = previewImage
	}
	
	func update() {
		tableView.reloadData()
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
	
}

extension WorkoutOfTheDayViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}
}
