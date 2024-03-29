//
//  String+constants.swift
//  Fitness App
//
//  Created by scales on 1/3/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Foundation

// MARK: - UserDefault
extension String {
	static var userDefaultsKeyIsTutorialShown: String { return "isTutorialShown" }
	static var userDefaultsKeyAccessTokenExpirationDate: String { return "accessTokenExpirationDate" }
}

// MARK: - Keychain
extension String {
	static var keychainKeyAccessToken: String { return "access_token" }
}

// MARK: - SegueIdentifiers
extension String {
	static var showTutorialSegueIdentifier: String { return "showTutorial" }
	static var showLoginSegueIdentifier: String { return "showLogin" }
	static var showFAQSegueIdentifier: String { return "showFAQ" }
	static var showHowToSegueIdentifier: String { return "showHowTo" }
	static var showVideoLibrarySegueIdentifier: String { return "showVideoLibrary" }
	static var showStoreSegueIdentifier: String { return "showStore" }
	static var showCoinsHistorySegueIdentifier: String { return "showCoinsHistory" }
	static var presentMainTabBarSegueIdentifier: String { return "presentMainTabBar"}
	static var presentCoinsAddedSegueIdentifier: String { return "presentCoinsAdded" }
	static var presentPhotoPreviewSegueIdentifier: String { return "presentPhotoPreview" }
	static var showProductDetailsSegueIdentifier: String { return "showProductDetails" }
	static var showSeasonsSegueIdentifier: String { return "showSeasons" }
	static var showVideoDetailsSegueIdentifier: String { return "showVideoDetails" }
}

// MARK: - Text Constants
extension String {
	static var wrongPasswordConstant: String { return "Wrong password" }
	static var wrongEmailConstant: String { return "Wrong E-mail" }
	static var forgotPasswordConstant: String { return "Forgot your password?" }
	static var emailWasSentConstant: String { return "E-mail with instructions on how to reset your password was sent" }
	static var closeConstant: String { return "Close" }
	static func successBoughtTextConst(name: String) -> String { return "You successfully bought \(name). We will contact you soon" }
	
	static var timerStartTime: String { return "00:00:00" }
	
	static var loremIpsumConstant: String {
		return "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,"
	}
}

