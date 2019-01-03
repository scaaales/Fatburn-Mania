//
//  Il.swift
//  Fitness App
//
//  Created by scales on 12/14/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit

protocol Identifierable {
	static var reuseIdentifier: String { get }
}

extension Identifierable {
	static var reuseIdentifier: String {
		return String(describing: Self.self)
	}
}
