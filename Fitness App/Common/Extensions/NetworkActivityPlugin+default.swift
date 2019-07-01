//
//  NetworkActivityPlugin+default.swift
//  Fitness App
//
//  Created by scales on 2/5/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

extension NetworkActivityPlugin {
	static var `default`: NetworkActivityPlugin {
		return NetworkActivityPlugin { (type, target) in
			switch type {
			case .began:
				DispatchQueue.main.async {
					UIApplication.shared.isNetworkActivityIndicatorVisible = true
				}
			case .ended:
				DispatchQueue.main.async {
					UIApplication.shared.isNetworkActivityIndicatorVisible = false
				}
			}
		}
	}
}
