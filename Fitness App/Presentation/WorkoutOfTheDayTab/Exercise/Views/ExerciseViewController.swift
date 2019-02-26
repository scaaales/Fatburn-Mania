//
//  ExerciseViewController.swift
//  Fitness App
//
//  Created by scales on 1/25/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit
import AVKit

class ExerciseViewController: UIViewController {
	var presenter: ExercisePresenter<ExerciseViewController>!
	
	var state: ExerciseState = .initialCountdown {
		didSet {
			switch state {
			case .initialCountdown:
				updateForInitialCountdown()
			case .playing:
				updateForPlaying()
			case .paused:
				updateForPaused()
			case .nextExerciseCountdown:
				updateForExerciseCountdown()
			}
		}
	}
	
	@IBOutlet private weak var initialCountdownLabel: UILabel!
	
	@IBOutlet private weak var progressView: UIProgressView!
	@IBOutlet private weak var currentTimeLabel: UILabel!
	@IBOutlet private weak var totalTimeLabel: UILabel!
	
	@IBOutlet private weak var nextExerciseTopLabel: UILabel!
	@IBOutlet private weak var nextExerciseCountdownLabel: UILabel!
	@IBOutlet private weak var nextExerciseHelperNameLabel: UILabel!
	
	@IBOutlet private weak var videoContainer: UIView!
	@IBOutlet private weak var pausedLabel: UILabel!
	@IBOutlet private weak var breakImageView: UIImageView!
	@IBOutlet private weak var playPauseButton: UIButton!
	
	@IBOutlet private weak var exerciseNameLabel: UILabel!
	@IBOutlet private weak var exerciseTimeLabel: UILabel!
	@IBOutlet private weak var nextExerciseNameLabel: UILabel!
	@IBOutlet private weak var tapTwiseLabel: UILabel!
	
	@IBOutlet private weak var resetButton: UIButton!
	
	@IBOutlet private weak var topNextExerciseStackViewConstraing: NSLayoutConstraint!
	
	private var playerViewController: AVPlayerViewController!
	var workoutOfTheDayViewController: WorkoutOfTheDayViewController?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		videoContainer.makeCornerRadius(15)
		setupVideoPlayer()
		presenter.getInitialExercise()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		progressView.subviews.forEach { $0.makeCornerRadius($0.bounds.height / 2) }
	}
	
	private func setupVideoPlayer() {
		playerViewController = AVPlayerViewController()
		
		videoContainer.addSubview(playerViewController.view)
		
		playerViewController.view.frame = videoContainer.bounds
		playerViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		playerViewController.showsPlaybackControls = false
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
	
	private func updateForInitialCountdown() {
		view.subviews.forEach { subview in
			if subview !== self.initialCountdownLabel {
				subview.alpha = 0
			}
		}
		navigationItem.hidesBackButton = true
	}
	
	private func updateForPlaying() {
		// from initial countdown
		view.subviews.forEach { subview in
			if subview !== self.initialCountdownLabel {
				subview.alpha = 1
			} else {
				subview.alpha = 0
			}
		}
		
		navigationItem.hidesBackButton = false
		
		// from paused
		playPauseButton.setImage(#imageLiteral(resourceName: "pauseButton"), for: .normal)
		playPauseButton.imageEdgeInsets.left = 0
		
		playerViewController.player?.play()
		
		exerciseNameLabel.alpha = 1
		exerciseTimeLabel.alpha = 1
		nextExerciseNameLabel.superview?.alpha = 1
		tapTwiseLabel.alpha = 1
		
		resetButton.isHidden = true
		
		// from countdown
		exerciseNameLabel.isHidden = false
		exerciseTimeLabel.isHidden = false
		nextExerciseNameLabel.superview?.isHidden = false
		tapTwiseLabel.isHidden = false
		
		nextExerciseHelperNameLabel.alpha = 0
		nextExerciseTopLabel.isHidden = true
		nextExerciseCountdownLabel.isHidden = true
		playPauseButton.isHidden = false
		
		topNextExerciseStackViewConstraing.isActive = false
	}
	
	private func updateForPaused() {
		playPauseButton.setImage(#imageLiteral(resourceName: "playButton"), for: .normal)
		playPauseButton.imageEdgeInsets.left = 5
		
		pausedLabel.text = "Paused"
		playerViewController.player?.pause()
		
		exerciseNameLabel.alpha = 0
		exerciseTimeLabel.alpha = 0
		nextExerciseNameLabel.superview?.alpha = 0
		tapTwiseLabel.alpha = 0
		
		resetButton.isHidden = false
	}
	
	private func updateForExerciseCountdown() {
		exerciseNameLabel.isHidden = true
		exerciseTimeLabel.isHidden = true
		nextExerciseNameLabel.superview?.isHidden = true
		tapTwiseLabel.isHidden = true
		
		nextExerciseHelperNameLabel.alpha = 1
		nextExerciseTopLabel.isHidden = false
		nextExerciseCountdownLabel.isHidden = false
		
		playPauseButton.isHidden = true
		topNextExerciseStackViewConstraing.isActive = true
		
		playerViewController.player = nil
	}
		
}

extension ExerciseViewController: ExerciseView {
	func setCountdownTime(_ countdownTime: TimeInterval) {
		initialCountdownLabel.text = countdownTime.stringSecondsOnly
		nextExerciseCountdownLabel.text = countdownTime.stringSecondsOnly
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
		nextExerciseHelperNameLabel.text = nextExerciseName ?? "-"
	}
	
	func setVideo(from url: URL) {
		playerViewController.view.isHidden = false
		if playerViewController.player == nil {
			playerViewController.player = AVPlayer(url: url)
			playerViewController.player?.play()
		}
		
		breakImageView.isHidden = true
	}
		
	func setBreakPicture() {
		pausedLabel.isHidden = true
		breakImageView.isHidden = false
		playerViewController.view.isHidden = true
	}
	
	func closeItself() {
		workoutOfTheDayViewController?.presenter.workoutFinished()
		navigationController?.popViewController(animated: true)
	}
	
}


