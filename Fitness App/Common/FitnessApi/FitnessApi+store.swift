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
		
		func getStoreItems(token: String,
						   onComplete: @escaping () -> Void,
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
		
		deinit {
			request?.cancel()
		}
	}
}
