// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productDetailResult = try? JSONDecoder().decode(ProductDetailResult.self, from: jsonData)

import Foundation

// MARK: - ProductDetailResultElement
struct ProductDetailResultElement: Codable, Identifiable, Hashable {
    var id: Int?
    var brand, productName, ingredients: String?

    enum CodingKeys: String, CodingKey {
        case id, brand
        case productName = "product_name"
        case ingredients
    }
}

typealias ProductDetailResult = [ProductDetailResultElement]
