//
//  APICosmify.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 19/06/23.
//

import Foundation

struct CosmilyAPIDataSource : APICosmilyDataSourceProtocol {
    
    
    // Get product analysis Post Request to Cosmily
    func getProductAnalysis(ingredientName: String) async -> Result<ProductAnalysis, CosmilyAPIError> {
        let url : URL = URL(string: "https://api.cosmily.com/api/v1/analyze/ingredient_list")!
        
        let requestBody : [String:String] = ["ingredients" : ingredientName]
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            
            let result = try decoder.decode(ProductAnalysis.self, from: data)
            
            return .success(result)
        } catch {
            if let urlError = error as? URLError {
                return .failure(.requestFailed(urlError))
            } else if let decodingError = error as? DecodingError {
                return .failure(.decodingFailed(decodingError))
            } else {
                return .failure(.invalidResponse)
            }
        }
    }
}
