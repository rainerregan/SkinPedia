//
//  APICosmilyDataSourceProtocol.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 19/06/23.
//

import Foundation

enum CosmilyAPIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

protocol APICosmilyDataSourceProtocol {
    func getProductAnalysis(ingredientName : String) async -> Result<ProductAnalysis, CosmilyAPIError>
}
