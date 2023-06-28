//
//  APICosmify.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 19/06/23.
//

import Foundation
import SwiftUI

struct CosmilyAPIDataSource : CosmilyAPIDataSourceProtocol {
    
    let model : coreDataManager = coreDataManager(modelName: "SkinPediaModel")
    let fetchResult : String? = nil
    
    func saveToCoreData(name : String) async {
        lazy var moc = model.container.viewContext
        
        let toBeSavedResult : ResultFetchAPI = ResultFetchAPI(context : moc)
        
        if let fResult = self.fetchResult {
            toBeSavedResult.resultString = fResult
            toBeSavedResult.scanName = name
            toBeSavedResult.date = Date()
        }
        
        
        
        do {
            try moc.save()
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
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
        
        print(String(describing: productAnalysisRequest))
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            print(String(decoding: data , as: UTF8.self))
            
            let fetchResult : String = String(decoding: data , as: UTF8.self)
            
            let decoder = JSONDecoder()
            let result = try decoder.decode(ProductAnalysisResult.self, from: data)
            
            return .success(result)
        } catch let error {
            print(String(describing: error))
            return .failure(.decodingFailed(error))
        }
    
    }
    
}
