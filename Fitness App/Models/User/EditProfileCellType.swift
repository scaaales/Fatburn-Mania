//
//  EditProfileCellType.swift
//  Fitness App
//
//  Created by scales on 1/15/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

struct EditProfileCellType {
	let fieldName: String
	let value: String
	let textType: UITextContentType?
	weak var delegate: UITextFieldDelegate?
	let tag: Int
	let dateInputView: UIDatePicker?
	let helperView: UIView?
}
