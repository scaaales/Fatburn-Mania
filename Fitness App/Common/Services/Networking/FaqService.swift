//
//  FaqService.swift
//  Fitness App
//
//  Created by scales on 2/25/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

enum FaqService {
	case getFAQ
	case getHowTo
}

extension FaqService: TargetType {
	var baseURL: URL { return .apiBaseURL }
	
	var path: String {
		switch self {
		case .getFAQ:
			return "/faq"
		case .getHowTo:
			return "/tutorial"
		}
	}
	
	var method: Method { return .get }
	
	var sampleData: Data { return .init() }
	
	var task: Task { return .requestPlain }
	
	var headers: [String : String]? {
		return ["Content-type": "application/json",
				"Accept": "application/json"]
	}
	
}
