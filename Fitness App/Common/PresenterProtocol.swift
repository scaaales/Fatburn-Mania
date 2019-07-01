//
//  PresenterProtocol.swift
//  Fitness App
//
//  Created by Sergey Kletsov on 11/5/18.
//  Copyright © 2018 Sergey Kletsov. All rights reserved.
//

import Foundation

protocol Presenter: AnyObject {
	associatedtype View
	var view: View! { get }
	init(view: View)
}
