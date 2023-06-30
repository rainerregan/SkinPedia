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
    
 
//    @Environment(\.managedObjectContext) var moc
//    var context = coreDataManager(modelName: "SkinPediaModel")
    
//    func fetchHistoryCoreData() -> [ResultFetchAPI] {
//        var results = [ResultFetchAPI]()
//        do {
//            results =
//            try self.moc.fetch(ResultFetchAPI.fetchRequest())
//        } catch {
//            print("couldnt fetch")
//        }
//        return historyData
//    }
    
    
//    func fetchHistory() -> [ProductAnalysisResult] {
//        let coreDataResults = fetchHistoryCoreData();
//        let decoder = JSONDecoder()
//
//        var productAnalysisResultList : [ProductAnalysisResult] = []
//
//        do {
//            for result in coreDataResults {
//                let result = try decoder.decode(ProductAnalysisResult.self, from: result.resultString?.data(using: .utf8) ?? Data())
//                productAnalysisResultList.append(result)
//            }
//        } catch let error {
//            print(String(describing: ex`rror))
//            return []
//        }
//
//        return productAnalysisResultList
//    }
}
