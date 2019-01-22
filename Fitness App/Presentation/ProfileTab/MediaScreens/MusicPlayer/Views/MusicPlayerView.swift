//
//  MusicPlayerView.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol MusicPlayerView: View {
	func update()
	func setTableViewDataSource(_ dataSource: UITableViewDataSource)
	func setCurrentSong(_ song: Song)
}
