//
//  APICosmify.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 19/06/23.
//

import Foundation

struct CosmilyAPIDataSource : CosmilyAPIDataSourceProtocol {
    
    func getProductAnalysis(productAnalysisRequest: ProductAnalysisRequest) async -> Result<ProductAnalysisResult, CosmilyAPIError> {
        
        guard let url : URL = URL(string: "https://api.cosmily.com/api/v1/analyze/ingredient_list") else {
            print("Invalid URL")
            return .failure(.invalidURL)
        }
        
        let requestBody : [String:String] = ["ingredients" : productAnalysisRequest.ingredients]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
        
        do {
            
            let task = try URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                if error == nil, let usableData=data {
                    let response =  try? JSONSerialization.jsonObject(with: usableData, options:[])
                    let result = try? JSONDecoder().decode(ProductAnalysisResult.self, from: usableData)
                    print(result) //JSONSerialization
                }
            }
            task.resume()
            
            return .success(ProductAnalysisResult(analysis: nil))
        } catch let error {
            return .failure(.decodingFailed(error))
        } catch {
            print("Fail: \(error)")
        }
        
//        let task = URLSession.shared.dataTask(with: request) {
//            data, response, error in
//
//            print(data)
//
//        }
//
//        task.resume()
//
//        return .success(ProductAnalysisResult(analysis: nil))
        
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//
//            //checks if there are errors regarding the HTTP status code and decodes using the passed struct
//            let fetchedData = try JSONDecoder().decode(ProductAnalysisResult.self, from: try data)
//
//            print(data)
//
//            return .success(fetchedData)
//        } catch {
//            return .failure(.invalidURL)
//        }
//
////        print(request, "REquest")
//
//        do {
//            let (data, response) = try await URLSession.shared.data(for: request)
//
//            print(response)
//
//            let decoder = JSONDecoder()
//
//            let result = try decoder.decode(ProductAnalysis.self, from: data)
//
//            return .success(ProductAnalysisResult(resultString: data.debugDescription))
//        } catch {
//            if let urlError = error as? URLError {
//                return .failure(.requestFailed(urlError))
//            } else if let decodingError = error as? DecodingError {
//                return .failure(.decodingFailed(decodingError))
//            } else {
//                return .failure(.invalidResponse)
//            }
//        }
    }
    
    
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
