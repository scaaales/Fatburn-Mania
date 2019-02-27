//
//  WorkoutOfTheDayViewController.swift
//  Fitness App
//
//  Created by scales on 1/24/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit
import AVKit

class WorkoutOfTheDayViewController: RootViewController {
	var presenter: WorkoutOfTheDayPresenter<WorkoutOfTheDayViewController>!
	
	@IBOutlet private weak var previewImageView: UIImageView!
	
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var rewardAndDurationLabel: UILabel!
	@IBOutlet private weak var descriptionLabel: UILabel!
	
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var tableViewHeight: NSLayoutConstraint!
	
	lazy private var loader: BlurredLoader = {
		let loader = BlurredLoader()
		view.addSubview(loader)
		loader.centerInto(view: view)
		return loader
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		presenter.getWorkoutOfTheDay()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		tableViewHeight.constant = tableView.contentSize.height
	}
	
	override func tryAgainTapped() {
		presenter.getWorkoutOfTheDay()
	}
	
	@IBAction private func openURL() {
		guard let url = URL(string: "https://www.google.com") else { return }
		UIApplication.shared.open(url, options: [:], completionHandler: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let exerciseVC = segue.destination as? ExerciseViewController {
			exerciseVC.presenter.exercises = presenter.exercises
			exerciseVC.workoutOfTheDayViewController = self
		} else if let coinsAddedVC = segue.destination as? CoinsAddedViewController,
			let coinsAmount = sender as? Int {
			coinsAddedVC.coinsAmount = coinsAmount
			coinsAddedVC.reasonAddedTextReplacement = "You finished wokout of the day and for this you get"
		}
	}
	
}

extension WorkoutOfTheDayViewController: WorkoutOfTheDayView {
	func showCoinsAddedScreen(with coinsNumber: Int) {
		performSegue(withIdentifier: .presentCoinsAddedSegueIdentifier, sender: coinsNumber)
	}
	
	func setPreviewImage(from urlString: String) {
		previewImageView.setImageFrom(urlString: urlString)
	}
	
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
	
	func hideAllViews() {
		view.subviews.forEach {
			if $0 != self.loader {
				$0.isHidden = true
			}
		}
	}
	
	func showAllViews() {
		view.subviews.forEach {
			if !($0 == self.loader || $0 == self.tryAgainButton) {
				$0.isHidden = false
			}
		}
	}
	
	func setLessonName(_ name: String, reward: Int, duration: TimeInterval, description: String) {
		nameLabel.text = name
		rewardAndDurationLabel.text = "\(reward) coins - \(duration.formattedWithFullText)"
		descriptionLabel.text = description
	}
	
	func update() {
		tableView.reloadData()
		tableView.setNeedsLayout()
		tableView.layoutIfNeeded()
		tableViewHeight.constant = tableView.contentSize.height
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
	
}

extension WorkoutOfTheDayViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if let url = presenter.getVideoUrl(at: indexPath.row) {
			let playerViewController = AVPlayerViewController()
			playerViewController.player = AVPlayer(url: url)
			present(playerViewController, animated: true)
		}
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}
}
