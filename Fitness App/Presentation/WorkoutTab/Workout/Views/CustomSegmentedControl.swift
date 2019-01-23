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
	private var selectedSegmentIndex = 0
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		updateView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		updateView()
	}
	
	func setItemsTitles(_ titles: [String]) {
		for buttonTitle in titles {
			let button = UIButton(type: .system)
			button.backgroundColor = .clear
			button.setTitle(buttonTitle, for: .normal)
			button.titleLabel?.font = .systemFont(ofSize: 17, weight: .light)
			button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
			
			button.translatesAutoresizingMaskIntoConstraints = false
			button.widthAnchor.constraint(equalToConstant: 40).isActive = true
			button.heightAnchor.constraint(equalToConstant: 40).isActive = true
			
			buttons.append(button)
		}
		updateView()
	}
	
	private func updateView() {
		if selector == nil {
			selector = UIView(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
			selector.layer.cornerRadius = selector.frame.height/2
			selector.layer.borderWidth = 0.5
			selector.layer.borderColor = UIColor.pinkColor.cgColor
			addSubview(selector)
		}
		
		// Create a StackView
		
		let stackView = UIStackView.init(arrangedSubviews: buttons)
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .equalCentering
		addSubview(stackView)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
		stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
		
		
	}

	@objc private func buttonTapped(button: UIButton) {
		for (buttonIndex, btn) in buttons.enumerated() {
			if btn == button {
				selectedSegmentIndex = buttonIndex
				
				let  selectorStartXPosition = btn.frame.origin.x
				
				UIView.animate(withDuration: 0.3) {
					self.selector.frame.origin.x = selectorStartXPosition
				}
			}
		}
		
		sendActions(for: .valueChanged)
	}
	
	
}

