//
//  ProductAnalysisRequest.swift
//  SkinPedia
//
//  Created by Rainer Regan on 20/06/23.
//

import Foundation

struct ProductAnalysisRequest: Identifiable {
    let id: String = UUID().uuidString
    var ingredients: String;
    
    internal init(ingredients: String) {
        self.ingredients = ingredients
    }
}
