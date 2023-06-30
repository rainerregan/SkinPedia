//
//  APICosmilyDataSourceProtocol.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 19/06/23.
//

import Foundation
import CoreData
enum CosmilyAPIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

protocol CosmilyAPIDataSourceProtocol {
    func getProductAnalysis(productAnalysisRequest: ProductAnalysisRequest) async -> Result<ProductAnalysisResult, CosmilyAPIError>
    func saveToCoreData(name : String, moc : NSManagedObjectContext) async
}
