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
    
    // MARK: - Output
    @Published var analyzedProductResult: ProductAnalysisResult = ProductAnalysisResult(analysis: nil)
    @Published var toBeAnalyzedRequest: ProductAnalysisRequest = ProductAnalysisRequest(ingredients: "water, linalool")
    
    
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
    
    private func onLoad() async {
        await getProductAnalysis()
    }
}

extension AnalysisResultViewModel {
    
    func didAppear() {
        Task {
            await onLoad()
        }
    }
}

