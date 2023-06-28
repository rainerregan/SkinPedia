//
//  RainersAPIDataSource.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 28/06/23.
//

import Foundation

struct ProductDetailDataSource : ProductDetailDataSourceProtocol {
    func getProductDetail(query: ProductDetailRequest) async -> Result<ProductDetailResult, ProductDetailAPIError> {
        guard let url : URL = URL(string: "http://test.exacode.io:3005/products?query=\(query.query)") else {
            print("URL invalid")
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            print(String(decoding: data , as: UTF8.self))
            
            let decoder = JSONDecoder()
            let result = try decoder.decode(ProductDetailResult.self, from: data)
            return .success(result)
            
        } catch let error {
            print(String(describing: error))
            return .failure(.decodingFailed(error))
        }
    }
}
