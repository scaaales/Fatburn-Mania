//
//  MeasurementsTextField.swift
//  Fitness App
//
//  Created by scales on 3/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class MeasurementsTextField: UITextField {

	private let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 19)
	
	override open func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(by: padding)
	}
	
	override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(by: padding)
	}
	
	override open func editingRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(by: padding)
	}

}
