//
//  APICosmilyDataSourceProtocol.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 19/06/23.
//

import Foundation

enum ProductDetailAPIError : Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

protocol ProductDetailDataSourceProtocol {
    func getProductDetail(query : ProductDetailRequest) async -> Result<ProductDetailResult, ProductDetailAPIError>
}
