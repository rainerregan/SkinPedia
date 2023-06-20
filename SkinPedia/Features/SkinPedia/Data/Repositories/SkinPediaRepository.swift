//
//  SkinPediaRepositories.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 20/06/23.
//

import Foundation

struct SkinPediaRepository : SkinPediaRepositoryProtocol {
    private var apiCosmilyDataSource : CosmilyAPIDataSource = CosmilyAPIDataSource();
    
    func getProductAnalysis(productAnalysisRequest: ProductAnalysisRequest) async -> Result<ProductAnalysisResult, CosmilyAPIError> {
        switch await apiCosmilyDataSource.getProductAnalysis(productAnalysisRequest: productAnalysisRequest) {
        case .success(let productAnalysisResult):
            return .success(productAnalysisResult)
        case .failure(let error):
            return .failure(error)
        }
    }
}
