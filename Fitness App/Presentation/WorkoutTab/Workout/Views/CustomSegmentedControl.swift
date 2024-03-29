//
//  CustomSegmentedControl.swift
//  Fitness App
//
//  Created by scales on 1/23/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

class CustomSegmentedControl: UIControl {
	
	private var buttons = [UIButton]()
	private var selector: UIView!
	
	private var onSelectAction: ((_ index: Int) -> Void)?
	
	func setItemsTitles(_ titles: [String]) {
		buttons.removeAll()
		for buttonTitle in titles {
			let button = UIButton(type: .system)
			button.backgroundColor = .clear
			button.setTitle(buttonTitle, for: .normal)
			button.titleLabel?.font = .systemFont(ofSize: 17, weight: .light)
			button.setTitleColor(.black, for: .normal)
			button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
			
			button.translatesAutoresizingMaskIntoConstraints = false
			button.widthAnchor.constraint(equalToConstant: 40).isActive = true
			button.heightAnchor.constraint(equalToConstant: 40).isActive = true
			
			buttons.append(button)
		}
		updateView()
	}
	
	func setOnSelectAction(action: @escaping (_ index: Int) -> Void) {
		onSelectAction = action
	}
	
	private func updateView() {
		let stackView = UIStackView(arrangedSubviews: buttons)
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .equalCentering
		addSubview(stackView)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
		stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
		
		stackView.layoutIfNeeded()
		
		if selector == nil,
			let lastButtonX = buttons.last?.frame.origin.x {
			selector = UIView(frame: CGRect.init(x: lastButtonX, y: 0,
												 width: 40, height: 40))
			selector.layer.cornerRadius = selector.frame.height/2
			selector.layer.borderWidth = 0.5
			selector.layer.borderColor = UIColor.pinkColor.cgColor
			addSubview(selector)
		}
	}

	@objc private func buttonTapped(button: UIButton) {
		for (buttonIndex, btn) in buttons.enumerated() {
			if btn == button {
				onSelectAction?(buttonIndex)
				
				let selectorStartXPosition = btn.frame.origin.x
				
				UIView.animate(withDuration: 0.3) {
					self.selector.frame.origin.x = selectorStartXPosition
				}
			}
		}
		
		sendActions(for: .valueChanged)
	}
	
	
}

