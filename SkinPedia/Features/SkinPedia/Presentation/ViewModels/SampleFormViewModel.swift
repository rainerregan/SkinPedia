//
//  SampleFormViewModel.swift
//  SkinPedia
//
//  Created by Rainer Regan on 20/06/23.
//

import Foundation

class SampleFormViewModel: ObservableObject {
    @Published var toBeAnalyzedRequest: ProductAnalysisRequest = ProductAnalysisRequest(ingredients: "water")

    func updateFieldData(_ data: String) {
        toBeAnalyzedRequest.ingredients = data
    }
}
