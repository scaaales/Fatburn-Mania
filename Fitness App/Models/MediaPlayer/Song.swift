//
//  Song.swift
//  Fitness App
//
//  Created by scales on 1/21/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

struct Song: Decodable {
	let title: String
	let subtitle: String
	let duration: String
	let audio: String
}
