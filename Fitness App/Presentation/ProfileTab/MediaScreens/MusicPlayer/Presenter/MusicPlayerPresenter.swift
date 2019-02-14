//
//  MusicPlayerPresenter.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

class MusicPlayerPresenter<V: MusicPlayerView>: Presenter {
	typealias View = V
	
	weak var view: View!
	private var viewModel: SongsTableViewModel!
	private var isMusicPlaying = false
	
	required init(view: View) {
		self.view = view
	}
	
	func getSongs() {
		viewModel = .init()
		view.setTableViewDataSource(viewModel.dataSource)
		view.update()
	}
	
	func playSong(at row: Int) {
		let song = viewModel.getSongAt(index: row)
		// some playing logic
		view.setCurrentSong(song)
		view.setPauseImage()
		isMusicPlaying = true
	}
	
	func pauseResumeSong() {
		isMusicPlaying.toggle()
		if isMusicPlaying {
			view.setPauseImage()
		} else {
			view.setPlayImage()
		}
	}
}
