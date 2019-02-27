//
//  LessonViewController.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit
import WebKit
import AVKit

class LessonViewController: UIViewController {
	var presenter: LessonPresenter<LessonViewController>!
	
	@IBOutlet private weak var lessonNameLabel: UILabel!
	@IBOutlet private weak var photoVideoViewContainer: UIView!
	@IBOutlet private weak var imageView: UIImageView!
	
	@IBOutlet private weak var startButton: UIButton!
	@IBOutlet private weak var lessonDescriptionLabel: UILabel!
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var tableViewHeight: NSLayoutConstraint!
	@IBOutlet private weak var digitLabel: UILabel!
	@IBOutlet private weak var photoButton: UIButton!

	private var playerViewController: AVPlayerViewController!
	
	lazy private var loader: BlurredLoader = {
		let loader = BlurredLoader()
		view.addSubview(loader)
		loader.centerInto(view: view)
		return loader
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		presenter.getLesson()
		photoVideoViewContainer.makeCornerRadius(15)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let exerciseVC = segue.destination as? ExerciseViewController {
			exerciseVC.presenter.exercises = presenter.exercises
			exerciseVC.lessonViewController = self
			exerciseVC.title = "Workout"
		} else if let photoVC = segue.destination as? PhotoViewController {
			photoVC.lessonViewController = self
			photoVC.presenter.shouldCloseItselfOnConfirm = true
			photoVC.presenter.shouldSavePhotoToLibrary = false
		}
	}
	
}

extension LessonViewController: LessonView {
	func setPhoto(from urlString: String) {
		imageView.setImageFrom(urlString: urlString)
	}
	
	func setVideo(from urlString: String) {
		imageView.removeFromSuperview()
		// some video setting logic
		guard let videoUrl = URL(string: urlString) else { return }
		playerViewController = AVPlayerViewController()
		playerViewController.player = AVPlayer(url: videoUrl)
		
		photoVideoViewContainer.addSubview(playerViewController.view)
		
		playerViewController.view.frame = photoVideoViewContainer.bounds
		playerViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
			if $0 != self.loader {
				$0.isHidden = false
			}
		}
	}
	
	func setupForNewsState() {
		tableView.removeFromSuperview()
		startButton.removeFromSuperview()
		digitLabel.removeFromSuperview()
		photoButton.removeFromSuperview()
	}
	
	func setTitle(_ title: String, lessonName: String, description: String, digitOfTheDay: String) {
		self.title = title
		lessonNameLabel.text = lessonName
		lessonDescriptionLabel.text = description
		digitLabel.text = digitOfTheDay
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

extension LessonViewController: UITableViewDelegate {
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


