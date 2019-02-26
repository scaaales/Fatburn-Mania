//
//  WorkoutOfTheDayView.swift
//  Fitness App
//
//  Created by scales on 1/24/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

protocol WorkoutOfTheDayView: View, TableViewUpdatable, NetworkingView, PopupShowable {
	func setLessonName(_ name: String,
					   reward: Int,
					   duration: TimeInterval,
					   description: String)
	func setLessonSponsorImage(_ sponsorImage: UIImage)
	func setPreviewImage(from urlString: String)
	
	func hideAllViews()
	func showAllViews()
	
	func showCoinsAddedScreen(with coinsNumber: Int)
}
