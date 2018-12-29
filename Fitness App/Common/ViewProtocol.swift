//
//  ViewProtocol.swift
//  Fitness App
//
//  Created by Sergey Kletsov on 11/5/18.
//  Copyright © 2018 Sergey Kletsov. All rights reserved.
//

import Foundation

protocol View: AnyObject {
	associatedtype Presenter
	var presenter: Presenter! { get set }
}
