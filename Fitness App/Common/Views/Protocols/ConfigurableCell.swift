//
//  ConfigurableCell.swft
//  Fitness App
//
//  Created by scales on 12/14/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit

protocol ConfigurableCell: class {
	associatedtype DataType = Void
	func configure(data: DataType)
	func configure()
}

extension ConfigurableCell {
	func configure(data: DataType) {}
	func configure() {}
}


