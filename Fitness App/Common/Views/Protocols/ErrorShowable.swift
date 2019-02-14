//
//  ErrorShowable.swift
//  Fitness App
//
//  Created by scales on 2/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol ErrorShowable {
	func showErrorPopup(with text: String)
}

extension ErrorShowable where Self: UIViewController {
	func showErrorPopup(with text: String) {
		let alertController = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
		alertController.addAction(.init(title: "Ok", style: .cancel))
		
		present(alertController, animated: true)
	}
}
