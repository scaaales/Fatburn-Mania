//
//  Configurator.swift
//  Fitness App
//
//  Created by Sergey Kletsov on 11/5/18.
//  Copyright © 2018 Sergey Kletsov. All rights reserved.
//

import Foundation

class Configurator<V: View, P: Presenter> where P.View == V, V.Presenter == P {
	private let view: V
	
	init(view: V) {
		self.view = view
	}
	
	func configurate() {
		let presenter = P.init(view: view)
		view.presenter = presenter
	}
}
