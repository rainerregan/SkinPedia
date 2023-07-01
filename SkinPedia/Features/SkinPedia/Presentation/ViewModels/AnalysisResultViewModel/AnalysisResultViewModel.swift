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
    
    @Published var goToCameraView : Bool = false;
    
    // MARK: - Output
    @Published var isSavingAllergen : Bool = false
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
    
    func saveToAllergenCoreData(result: ProductAnalysisResult, moc : NSManagedObjectContext) {
        
        let allergensCount : Int = result.analysis?.harmful?.allergen?.count ?? 0;
        var allergenIngredientNames = "aw";
        
        if allergensCount > 0 {
            let itemList : [ItemList] = result.analysis?.harmful?.allergen?.itemList ?? []
            
            itemList.forEach{
                allergenIngredientNames = "\(allergenIngredientNames) \($0.alias ?? "No Name"),"
            }
        }
        
        if allergenIngredientNames != "" {
            let allergenData : AllergenIngredient = AllergenIngredient(context : moc)
            allergenData.ingredientName = allergenIngredientNames
            
            do {
                try moc.save()
                print("Saving Success")
            } catch let err {
                print("error saving Allergen entity with : \(err.localizedDescription)")
            }
        } else {
            print("allergen kosong tidak harus di save")
        }
        
        
        
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
        if !self.isSavingAllergen {
            await saveResult(moc : moc)
        }
    }
}

extension AnalysisResultViewModel {
    
    func didAppear(moc : NSManagedObjectContext) {
        Task {
            await onLoad(moc : moc)
        }
    }
}

