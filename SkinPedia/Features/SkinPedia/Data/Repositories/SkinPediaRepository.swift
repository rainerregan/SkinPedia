//
//  SkinPediaRepositories.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 20/06/23.
//

import Foundation

struct SkinPediaRepository : SkinPediaRepositoryProtocol {
    private var apiCosmilyDataSource : CosmilyAPIDataSource = CosmilyAPIDataSource();
    private var rainerAPIDataSource : RainersAPIDataSource = RainersAPIDataSource();
    
    func saveToCoreData(name: String) async {
        await apiCosmilyDataSource.saveToCoreData(name: name)
    }
    
    func getQuerryData(querryRequest: RainerApiRequest) async -> Result<RainersAPIResult, RainersAPIError> {
        switch await rainerAPIDataSource.getQuerryData(querryRequest: querryRequest) {
        case .success(let querryData) :
            return .success(querryData)
        case .failure(let err) :
            return .failure(err)
        }
    }
    
    
    
    func getProductAnalysis(productAnalysisRequest: ProductAnalysisRequest) async -> Result<ProductAnalysisResult, CosmilyAPIError> {
        switch await apiCosmilyDataSource.getProductAnalysis(productAnalysisRequest: productAnalysisRequest) {
        case .success(let productAnalysisResult):
            return .success(productAnalysisResult)
        case .failure(let error):
            return .failure(error)
        }
    }
}
