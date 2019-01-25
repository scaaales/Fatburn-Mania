//
//  ExerciseViewController.swift
//  Fitness App
//
//  Created by scales on 1/25/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
	var presenter: ExercisePresenter<ExerciseViewController>!
	
	@IBOutlet private weak var progressView: UIProgressView!
	@IBOutlet private weak var currentTimeLabel: UILabel!
	@IBOutlet private weak var totalTimeLabel: UILabel!
	
	@IBOutlet private weak var videoContainer: UIView!
	@IBOutlet private weak var playPauseButton: UIButton!
	
	// hideable
	@IBOutlet private weak var exerciseNameLabel: UILabel!
	@IBOutlet private weak var exerciseTimeLabel: UILabel!
	@IBOutlet private weak var nextExerciseNameLabel: UILabel!
	@IBOutlet private weak var tapTwiseLabel: UILabel!
	
	@IBOutlet private weak var resetButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		progressView.subviews.forEach { $0.makeCornerRadius($0.bounds.height / 2) }
		presenter.getInitialExercise()
	}
	
	@IBAction private func playPauseTapped() {
		presenter.togglePaused()
	}
	
	@IBAction private func resetTapped() {
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func doubleTapped(_ sender: Any) {
		presenter.getNextExercise()
	}
	
	private func setHideableViewsAlpha(_ alpha: CGFloat) {
		exerciseNameLabel.alpha = alpha
		exerciseTimeLabel.alpha = alpha
		nextExerciseNameLabel.superview?.alpha = alpha
		tapTwiseLabel.alpha = alpha
	}
	
}

extension ExerciseViewController: ExerciseView {
	func setupForPausedState() {
		playPauseButton.setImage(#imageLiteral(resourceName: "playButton"), for: .normal)
		playPauseButton.imageEdgeInsets.left = 5
		
		setHideableViewsAlpha(0)
		
		resetButton.isHidden = false
	}
	
	func setupForPlayingState() {
		playPauseButton.setImage(#imageLiteral(resourceName: "pauseButton"), for: .normal)
		playPauseButton.imageEdgeInsets.left = 0
		
		setHideableViewsAlpha(1)
		
		resetButton.isHidden = true
	}
	
	func setCurrentTime(_ currentTime: TimeInterval) {
		currentTimeLabel.text = currentTime.stringFromTimeInterval
	}
	
	func setTotalTime(_ totalTime: TimeInterval) {
		totalTimeLabel.text = totalTime.stringFromTimeInterval
	}
	
	func setPercentageProgress(_ percentage: Float) {
		progressView.setProgress(percentage, animated: true)
	}
	
	func setExerciseTime(_ exerciseTime: TimeInterval) {
		exerciseTimeLabel.text = exerciseTime.stringFromTimeInterval
	}
	
	func setExerciseName(_ exerciseName: String) {
		exerciseNameLabel.text = exerciseName
	}
	
	func setNextExerciseName(_ nextExerciseName: String?) {
		nextExerciseNameLabel.text = nextExerciseName ?? "-"
	}
	
	func setVideo() {
		let label = UILabel()
		label.text = "Imagine there is a video playing here"
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 35, weight: .bold)
		label.textColor = .white
		label.backgroundColor = .gray
		label.textAlignment = .center
		videoContainer.addSubview(label)
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.leftAnchor.constraint(equalTo: videoContainer.leftAnchor).isActive = true
		label.rightAnchor.constraint(equalTo: videoContainer.rightAnchor).isActive = true
		label.topAnchor.constraint(equalTo: videoContainer.topAnchor).isActive = true
		label.bottomAnchor.constraint(equalTo: videoContainer.bottomAnchor).isActive = true
		
		videoContainer.makeCornerRadius(15)
	}
	
}


