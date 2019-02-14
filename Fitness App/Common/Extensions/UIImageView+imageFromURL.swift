//
//  UIImageView+imageFromURL.swift
//  Fitness App
//
//  Created by scales on 2/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import UIKit
import Alamofire

fileprivate let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
	
	func setImageFrom(urlString: String) {
		if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
			self.image = imageFromCache
		} else {
			Alamofire.request(urlString).responseData { [weak self] response in
				if let data = response.data,
					let image = UIImage(data: data) {
					imageCache.setObject(image, forKey: urlString as NSString)
					DispatchQueue.main.async {
						self?.image = image
					}
				}
			}
		}
	}
}
