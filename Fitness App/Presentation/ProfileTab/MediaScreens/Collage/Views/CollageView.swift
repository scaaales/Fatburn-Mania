//
//  CollageView.swift
//  Fitness App
//
//  Created by scales on 1/16/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol CollageView: View {
	var viewControllerToPresentPicker: UIViewController { get }
	
	func hideAddLeftPartButton()
	func hideAddRightPartButton()
	func setImageForLeftPart(_ image: UIImage)
	func setImageForRightPart(_ image: UIImage)
}
