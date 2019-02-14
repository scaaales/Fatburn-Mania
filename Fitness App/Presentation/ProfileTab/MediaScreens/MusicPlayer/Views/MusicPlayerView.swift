//
//  MusicPlayerView.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//


protocol MusicPlayerView: View, TableViewUpdatable {	
	func setCurrentSong(_ song: Song)
	func setPauseImage()
	func setPlayImage()
}
