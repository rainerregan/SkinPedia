//
//  RainersAPIDataSource.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 28/06/23.
//

import Foundation

struct RainersAPIDataSource : RainersAPIDataSourceProtocol {
    func getQuerryData(querryRequest: RainerApiRequest) async -> Result<RainersAPIResult, RainersAPIError> {
        guard let url : URL  = URL (string: "test.exacode.io:3005/products?query=\(querryRequest.productName)") else {
            print("URL invalid")
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            print(String(decoding: data , as: UTF8.self))
            
            
            let decoder = JSONDecoder()
            let result = try decoder.decode(RainersAPIResult.self, from: data)
            return .success(result)
            
        } catch let error {
            print(String(describing: error))
            return .failure(.decodingFailed(error))
        }
        
    }
    
    
}
