//
//  Character+isNumber.swift
//  Fitness App
//
//  Created by scales on 2/20/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

extension Character {
	var isNumber: Bool {
		return ["0", "1", "2", "3", "4", "5", "6", "7" , "8", "9"].contains(self)
	}
}
