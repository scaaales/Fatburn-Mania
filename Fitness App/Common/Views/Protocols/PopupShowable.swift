//
//  PopupShowable.swift
//  Fitness App
//
//  Created by scales on 2/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol PopupShowable {
	func showPopup(with title: String?, text: String)
	func showErrorPopup(with text: String)
}

extension PopupShowable where Self: UIViewController {
	func showPopup(with title: String?, text: String) {
		let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
		alertController.addAction(.init(title: "Ok", style: .cancel))
		
		present(alertController, animated: true)
	}
	
	func showErrorPopup(with text: String) {
		showPopup(with: "Error", text: text)
	}
 }
