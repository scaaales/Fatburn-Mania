//
//  Array+extension.swift
//  Fitness App
//
//  Created by scales on 1/25/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

extension Array {
	subscript (safe index: Int) -> Element? {
		guard index >= 0 else { return nil }
		return index < count ? self[index] : nil
	}
}

extension Array where Element == Exercise {
	var totalDuration: TimeInterval {
		return self.reduce(0, { $0 + $1.duration })
	}
}
extension Array where Element: Hashable {
	var unique: [Element] {
		return Array(Set(self))
	}
}
