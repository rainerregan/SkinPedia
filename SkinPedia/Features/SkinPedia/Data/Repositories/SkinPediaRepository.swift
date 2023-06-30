//
//  SkinPediaRepositories.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 20/06/23.
//

import Foundation
import CoreData
struct SkinPediaRepository : SkinPediaRepositoryProtocol {

    private var apiCosmilyDataSource : CosmilyAPIDataSource = CosmilyAPIDataSource();
    private var productDetailDataSource : ProductDetailDataSource = ProductDetailDataSource();
    
    func saveToCoreData(name: String, fetchResult:String, moc : NSManagedObjectContext) async {
        await apiCosmilyDataSource.saveToCoreData(name: name, fetchResult: fetchResult, moc : moc)
    }
    
    func getProductDetail(query: ProductDetailRequest) async -> Result<ProductDetailResult, ProductDetailAPIError> {
        switch await productDetailDataSource.getProductDetail(query: query) {
        case .success(let data) :
            return .success(data)
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
