//
//  DefaultSectionHeader.swift
//  Fitness Test App
//
//  Created by scales on 12/16/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

class DefaultSectionHeader: UITableViewCell, ConfigurableCell {
	typealias DataType = String
	
	@IBOutlet private weak var sectionName: UILabel!
	
	func configure(data: String) {
		sectionName.text = data
	}

}
