//
//  VideoLibraryView.swift
//  Fitness App
//
//  Created by scales on 1/10/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol VideoLibraryView: View {
	func update()
	func setCollectionViewDataSource(_ dataSource: UICollectionViewDataSource)
}
