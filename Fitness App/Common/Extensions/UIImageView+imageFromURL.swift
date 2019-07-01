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
			let loader = UIActivityIndicatorView(style: .gray)
			addSubview(loader)
			loader.translatesAutoresizingMaskIntoConstraints = false
			loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
			loader.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
			loader.startAnimating()
			Alamofire.request(urlString).responseData { [weak self] response in
				if let data = response.data,
					let image = UIImage(data: data) {
					imageCache.setObject(image, forKey: urlString as NSString)
					DispatchQueue.main.async {
						loader.stopAnimating()
						loader.removeFromSuperview()
						self?.image = image
					}
				}
			}
		}
	}
}
