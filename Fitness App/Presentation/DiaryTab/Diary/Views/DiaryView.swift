//
//  DiaryView.swift
//  Fitness App
//
//  Created by scales on 12/29/18.
//  Copyright © 2018 Ridex. All rights reserved.
//

import UIKit

protocol DiaryView: View, TableViewUpdatable, NetworkingView, PopupShowable {
	func showTableView()
	func hideTableView()
}
