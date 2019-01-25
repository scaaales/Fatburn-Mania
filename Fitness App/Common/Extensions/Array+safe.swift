//
//  Array+safe.swift
//  Fitness App
//
//  Created by scales on 1/25/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

extension Array {
	subscript (safe index: Int) -> Element? {
		 return index < count ? self[index] : nil
	}
}
