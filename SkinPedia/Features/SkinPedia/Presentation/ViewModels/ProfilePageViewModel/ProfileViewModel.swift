//
//  ProfileViewModel.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 27/06/23.
//

import Foundation
import CoreData
import SwiftUI

class ProfileViewModel : ObservableObject {
    @Published var showProfiling = false
    
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(sortDescriptors: []) var historyData : FetchedResults<ResultFetchAPI>
    
//    var context = coreDataManager(modelName: "SkinPediaModel")
    
    func fetchHistoryCoreData() -> [ResultFetchAPI] {
        var results = [ResultFetchAPI]()
        do {
            results =
            try self.moc.fetch(ResultFetchAPI.fetchRequest())
        } catch {
            print("couldnt fetch")
        }
        return results
    }
    
    func validateJSON(jsonString: String) -> Bool {
        let jsonData = jsonString.data(using: String.Encoding.utf8)

        if JSONSerialization.isValidJSONObject(jsonData) {
            return true
        } else {
            return false
        }
    }
    
    func fetchHistory() -> [ProductAnalysisResult] {
        let coreDataResults = fetchHistoryCoreData();
        let decoder = JSONDecoder()
        
        var productAnalysisResultList : [ProductAnalysisResult] = []
        
        for result in coreDataResults {
            if(result.resultString == nil) {continue}
            
//            if(!validateJSON(jsonString: result.resultString ?? "")) {
//                print("invalid JSON \(result.resultString)")
//            }
            
            do {
                let result = try decoder.decode(ProductAnalysisResult.self, from: result.resultString?.data(using: .utf8) ?? Data())
                productAnalysisResultList.append(result)
            } catch let error {
                continue
            }
            
        }
        
        
        return productAnalysisResultList
    }
}
