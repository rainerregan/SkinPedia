//
//  GetProductAnalysisUseCase.swift
//  SkinPedia
//
//  Created by Rainer Regan on 20/06/23.
//

import Foundation

struct GetProductAnalysisUseCase {
    let skinpediaRepository = SkinPediaRepository()
    
    func call(productAnalysisRequest : ProductAnalysisRequest) async -> Result<ProductAnalysisResult, CosmilyAPIError> {
        return await skinpediaRepository.getProductAnalysis(productAnalysisRequest: productAnalysisRequest)
    }
}
