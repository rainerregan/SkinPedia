//
//  AnalysisResultViewModel.swift
//  SkinPedia
//
//  Created by Rainer Regan on 20/06/23.
//

import Foundation
import Combine
import SwiftUI
import CoreData

protocol AnalysisResultViewModelProtocol : AnalysisResultViewModelInput, AnalysisResultViewModelOutput {}

class AnalysisResultViewModel: ObservableObject, AnalysisResultViewModelProtocol {
    @Published var toBeAnalyzedProductName : String = "";
//    @Published var model = coreDataManager(modelName: "SkinPediaModel")
    
    // MARK: - Output
    @Published var analyzedProductResult: ProductAnalysisResult = ProductAnalysisResult(analysis: nil)
    @Published var toBeAnalyzedRequest: ProductAnalysisRequest = ProductAnalysisRequest(ingredients: "water")
    
    
    init(result: ProductAnalysisResult? = nil) {
        self.analyzedProductResult = result ?? ProductAnalysisResult(analysis: nil)
    }
    
    // Memfilter data ingredient berdasarkan allergen yang di pass. Mengecek alias
    func filterIngredientByAllergent(allergent: ItemList) -> [IngredientsTable] {
        var filteredIngredient = analyzedProductResult.analysis?.ingredientsTable?.filter({$0.alias == allergent.alias})
        return filteredIngredient ?? []
    }
    
    // MARK: - Private
    private func getProductAnalysis() async {
        let productAnalysisResult = await GetProductAnalysisUseCase().call(productAnalysisRequest: ProductAnalysisRequest(ingredients: toBeAnalyzedRequest.ingredients))
        switch productAnalysisResult {
        case .success(let result):
            await MainActor.run {
                self.analyzedProductResult = result
            }
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    func saveToCoreData(name : String, fetchResult: String, moc : NSManagedObjectContext) async {
        await saveToCoreDataUseCase().skinPediaRepository.saveToCoreData(name: name, fetchResult: fetchResult, moc : moc);
    }
    
    func saveResult(moc : NSManagedObjectContext) async {
        Task {
            var name = self.toBeAnalyzedProductName
            var encoder = JSONEncoder()
            var encodedData = try! encoder.encode(self.analyzedProductResult)
            let jsonString = String(data: encodedData, encoding: .utf8)
            
            await self.saveToCoreData(name: name, fetchResult: jsonString!, moc : moc)
        }
    }
    
    private func onLoad(moc : NSManagedObjectContext) async {
        await getProductAnalysis()
        await saveResult(moc : moc)
    }
}

extension AnalysisResultViewModel {
    
    func didAppear(moc : NSManagedObjectContext) {
        Task {
            await onLoad(moc : moc)
        }
    }
}

