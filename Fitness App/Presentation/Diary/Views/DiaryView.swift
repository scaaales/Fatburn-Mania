//
//  DiaryView.swift
//  Fitness App
//
//  Created by scales on 12/29/18.
//  Copyright © 2018 kpi. All rights reserved.
//

import UIKit

protocol DiaryView: View {
	func update()
	func showLoader()
	func hideLoader()
	func showTableView()
	func hideTableView()
}
