//
//  Rainer'sAPIRequest.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 28/06/23.
//

import Foundation

struct RainerApiRequest : Identifiable {
    let id: String = UUID().uuidString
    var productName: String;
    
    init(productName: String) {
        self.productName = productName
    }
}
