//
//  MusicPlayerViewController.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class MusicPlayerViewController: UIViewController {
	var presenter: MusicPlayerPresenter<MusicPlayerViewController>!
	
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var volumeSlider: UISlider!
	@IBOutlet private weak var currentSongLabel: UILabel!
	@IBOutlet private weak var playPauseButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		for state in [UIControl.State.normal, .highlighted] {
			volumeSlider.setThumbImage(#imageLiteral(resourceName: "thumbWithShadow"), for: state)
		}
		setupTableView()
		presenter.getSongs()
	}
	
	private func setupTableView() {
		tableView.delegate = self
		tableView.backgroundColor = .white
	}
	
	@IBAction private func prevTapped() {
		
	}
	
	@IBAction private func currentSongPlayPauseTapped() {
		presenter.pauseResumeSong()
	}
	
	@IBAction private func nextTapped() {
		
	}
	
	@IBAction private func volumeSliderValueChanged() {
		
	}
	
	@IBAction private func playPauseTappedOnSong(_ sender: UIButton) {
		let row = sender.tag
		presenter.playSong(at: row)
	}
	
}

extension MusicPlayerViewController: MusicPlayerView {
	func setPauseImage() {
		playPauseButton.setImage(#imageLiteral(resourceName: "pauseSongImageBlack"), for: .normal)
	}
	
	func setPlayImage() {
		playPauseButton.setImage(#imageLiteral(resourceName: "playSongImageBlack"), for: .normal)
	}
	
	func setTableViewDataSource(_ dataSource: UITableViewDataSource) {
		tableView.dataSource = dataSource
	}
	
	func update() {
		tableView.reloadData()
	}
	
	func setCurrentSong(_ song: Song) {
		currentSongLabel.text = "\(song.name) - \(song.artist)"
	}
}

extension MusicPlayerViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 15
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 86
	}
}

