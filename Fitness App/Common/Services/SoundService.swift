//
//  SoundService.swift
//  Fitness App
//
//  Created by scales on 3/28/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import AudioToolbox

enum SoundService {
	enum Sound: String {
		case coins
		case waterAdded
		case waterRemoved
		case timer
	}
	
	static func play(sound: Sound) {
		guard let filePath = Bundle.main.path(forResource: sound.rawValue, ofType: "mp3") else { return }
		let soundUrl = NSURL(fileURLWithPath: filePath)
		var soundId: SystemSoundID = 0
		AudioServicesCreateSystemSoundID(soundUrl, &soundId)
		AudioServicesPlaySystemSound(soundId)
	}
}
