//
//  FitnessApi+store.swift
//  Fitness App
//
//  Created by scales on 2/14/19.
//  Copyright © 2019 Ridex. All rights reserved.
//

import Moya

extension FitnessApi {
	class Store {
		private class ProductsResponse: Decodable {
			let products: [Product]
			let success: Bool
			
			enum CodingKeys: String, CodingKey {
				case products = "store_items"
				case success
			}
		}
		
		private let provider = MoyaProvider<StoreService>(plugins: [NetworkActivityPlugin.default])
		
		private var request: Cancellable?
		private let token: String
		
		init(token: String) {
			self.token = token
		}
		
		func getStoreItems(onComplete: @escaping () -> Void,
						   onSuccess: @escaping ([Product]) -> Void,
						   onError: @escaping OnErrorCompletion) {
			request = provider.request(.getStoreItems(token: token), completion: { result in
				onComplete()
				mapResult(result,
						  intoItemOfType: ProductsResponse.self,
						  onSuccess: { productsResponse in
							onSuccess(productsResponse.products)
				},
						  onError: onError)
			})
		}
		
		func butStoreItems(productId: Int,
						   onComplete: @escaping () -> Void,
						   onSuccess: @escaping () -> Void,
						   onError: @escaping OnErrorCompletion) {
			request = provider.request(.buyStoreItems(token: token,
													  productId: productId),
									   completion: { result in
										onComplete()
										handleResult(result, onSuccess: { json in
											if let success = json["success"] as? Bool {
												if success {
													onSuccess()
												} else {
													if let error = json["error"] as? String {
														onError(error)
													}
												}
											}
										}, onError: onError)
			})
		}
		
		deinit {
			request?.cancel()
		}
	}
}
