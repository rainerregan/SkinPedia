//
//  SkinPediaRepositoryProtocol.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 20/06/23.
//

import Foundation

protocol SkinPediaRepositoryProtocol {
    func getProductAnalysis(productAnalysisRequest: ProductAnalysisRequest) async -> Result<ProductAnalysisResult, CosmilyAPIError>
    func getProductDetail(query : ProductDetailRequest) async -> Result<ProductDetailResult, ProductDetailAPIError>
    func saveToCoreData(name : String) async
}
