//
//  MusicPlayerPresenter.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation
import KeychainSwift
import AVFoundation

class MusicPlayerPresenter<V: MusicPlayerView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: SongsTableViewModel!
	private let profileAPI: FitnessApi.Profile
	private var isMusicPlaying = false
	private var player: AVPlayer?
	private var currentSongIndex: Int?
	private var currentVolume: Float = 1
	
	required init(view: View) {
		self.view = view
		
		let keychain = KeychainSwift()
		guard let token = keychain.get(.keychainKeyAccessToken) else {
			fatalError("cannot find access token")
		}
		
		profileAPI = .init(token: token)
	}
	
	func getSongs() {
		view.disableUserInteraction()
		view.showLoader()
		
		profileAPI.getSongs(onComplete: { [weak self] in
			self?.view.enableUserInteraction()
			self?.view.hideLoader()
		}, onSuccess: { [weak self] songs in
			guard let self = self else { return }
			self.viewModel = .init(items: songs)
			self.view.setTableViewDataSource(self.viewModel.dataSource)
			self.view.update()
		}) { [weak self] errorText in
			self?.view.showErrorPopup(with: errorText)
		}
	}
	
	func playSong(at row: Int) {
		guard let song = viewModel.getSongAt(index: row),
			let fixedSongUrlString = song.audio.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
			let songURL = URL(string: fixedSongUrlString) else { return }
		
		currentSongIndex = row
		setupAudioSession()
		player = AVPlayer(url: songURL)
		player?.play()
		player?.volume = currentVolume
		view.setVolume(value: currentVolume)
		
		NotificationCenter.default.addObserver(self,
											   selector: #selector(playNextSong),
											   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
											   object: nil)
		
		view.setCurrentSong(song)
		view.setPauseImage()
		isMusicPlaying = true
	}
	
	@objc func playNextSong() {
		guard let currentSongIndex = currentSongIndex else { return }
		playSong(at: currentSongIndex + 1)
	}
	
	func playPrevSong() {
		guard let currentSongIndex = currentSongIndex else { return }
		playSong(at: currentSongIndex - 1)
	}
	
	private func setupAudioSession() {
		let audioSession = AVAudioSession.sharedInstance()
		
		do {
			try audioSession.setCategory(.playback, mode: .default)
			try audioSession.setActive(true)
		} catch {
			print(error)
		}
	}
	
	func changeVolumeTo(value: Float) {
		currentVolume = value
		player?.volume = value
	}
	
	func pauseResumeSong() {
		isMusicPlaying.toggle()
		if isMusicPlaying {
			player?.play()
			view.setPauseImage()
		} else {
			player?.pause()
			view.setPlayImage()
		}
	}
}
