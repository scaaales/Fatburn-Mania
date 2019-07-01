//
//  Integer+formatted.swift
//  Fitness App
//
//  Created by scales on 1/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

fileprivate extension Formatter {
	static let withSeparator: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.groupingSeparator = " "
		formatter.numberStyle = .decimal
		return formatter
	}()
}

extension BinaryInteger {
	var formattedWithSeparator: String {
		return Formatter.withSeparator.string(for: self) ?? ""
	}
}
