//
//  FitnessApi+Faq.swift
//  Fitness App
//
//  Created by scales on 2/25/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

extension FitnessApi {
	class FAQ: BaseApi {
		private let provider = MoyaProvider<FaqService>(plugins: [NetworkActivityPlugin.default])
		
		func getFaqHtmlString(onComplete: @escaping () -> Void,
							  onSuccess: @escaping (String) -> Void,
							  onError: @escaping OnErrorCompletion) {
			request = provider.request(.getFAQ, completion: { result in
				BaseApi.handleResult(result, onSuccess: { json in
					onComplete()
					if let faqHtmlString = json["content"] as? String {
						onSuccess(faqHtmlString)
					} else {
						onError("Cannot extract html :(")
					}
				}, onError: onError)
			})
		}
		
		func getHowToHtmlString(onComplete: @escaping () -> Void,
								onSuccess: @escaping (String) -> Void,
								onError: @escaping OnErrorCompletion) {
			request = provider.request(.getFAQ, completion: { result in
				BaseApi.handleResult(result, onSuccess: { json in
					onComplete()
					if let faqHtmlString = json["content"] as? String {
						onSuccess(faqHtmlString)
					} else {
						onError("Cannot extract html :(")
					}
				}, onError: onError)
			})
		}
		
	}
}
