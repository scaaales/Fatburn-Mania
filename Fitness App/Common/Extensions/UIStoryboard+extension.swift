//
//  UIStoryboard+extension.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit

extension UIStoryboard {
	static var loginStack: UIStoryboard { return UIStoryboard(name: "LoginStack", bundle: nil) }
	static var diaryTab: UIStoryboard { return UIStoryboard(name: "DiaryTab", bundle: nil) }
	static var loadingSplash: UIStoryboard { return UIStoryboard(name: "LoadingSplash", bundle: nil) }
	static var storeStack: UIStoryboard { return UIStoryboard(name: "StoreStack", bundle: nil) }
	static var notifications: UIStoryboard { return UIStoryboard(name: "Notifications", bundle: nil) }
}
