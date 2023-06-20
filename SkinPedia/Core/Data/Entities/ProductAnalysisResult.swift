//
//  ProductAnalysisResult.swift
//  SkinPedia
//
//  Created by Rainer Regan on 20/06/23.
//

import Foundation

struct ProductAnalysisResult: Identifiable {
    let id: String = UUID().uuidString
    var resultString: String
    
    internal init(resultString: String) {
        self.resultString = resultString
    }
}
