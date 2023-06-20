// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productAnalysisResult = try? JSONDecoder().decode(ProductAnalysisResult.self, from: jsonData)

import Foundation

// MARK: - ProductAnalysisResult
struct ProductAnalysisResult: Codable {
    let analysis: Analysis?
}

// MARK: - Analysis
struct Analysis: Codable {
    let totalIngredients: Int?
    let ingredientsTable: [IngredientsTable]?
    let harmful: Harmful?
    let positive: Positive?
    let notable: Notable?
    let ewg: AnalysisEwg?
    let natural: Natural?
    let text, description, shareToken: String?
    let ingredientGroup, ownerUser: JSONNull?
    let permissions: Permissions?

    enum CodingKeys: String, CodingKey {
        case totalIngredients = "total_ingredients"
        case ingredientsTable = "ingredients_table"
        case harmful, positive, notable, ewg, natural, text, description
        case shareToken = "share_token"
        case ingredientGroup = "ingredient_group"
        case ownerUser = "owner_user"
        case permissions
    }
}

// MARK: - AnalysisEwg
struct AnalysisEwg: Codable {
    let unknown, low, moderate, high: High?
}

// MARK: - High
struct High: Codable {
    let count: Int?
    let percent: Double?
}

// MARK: - Harmful
struct Harmful: Codable {
    let allergen, alcohol, comedogenicRating, gluten: Alcohol?
    let silicone, sulfate, paraben, peg: Alcohol?
    let fungalAcneFeeding, fragrance: Alcohol?

    enum CodingKeys: String, CodingKey {
        case allergen, alcohol
        case comedogenicRating = "comedogenic_rating"
        case gluten, silicone, sulfate, paraben, peg
        case fungalAcneFeeding = "fungal_acne_feeding"
        case fragrance
    }
}

// MARK: - Alcohol
struct Alcohol: Codable {
    let title, description, imageURL: String?
    let list: [List]?
    let count: Int?
    let slug: String?

    enum CodingKeys: String, CodingKey {
        case title, description
        case imageURL = "image_url"
        case list, count, slug
    }
}

// MARK: - List
struct List: Codable {
    let index: Int?
    let title, alias: String?
}

// MARK: - IngredientsTable
struct IngredientsTable: Codable {
    let index: Int?
    let title: String?
    let alias: String?
    let id: Int?
    let introtext: String?
    let cirRating: CIRRating?
    let booleanProperties: [String: Bool]?
    let integerProperties: IntegerProperties?
    let ewg: IngredientsTableEwg?
    let categories: String?

    enum CodingKeys: String, CodingKey {
        case index, title, alias, id, introtext
        case cirRating = "cir_rating"
        case booleanProperties = "boolean_properties"
        case integerProperties = "integer_properties"
        case ewg, categories
    }
}

enum CIRRating: String, Codable {
    case a = "A"
    case b = "B"
    case empty = ""
}

// MARK: - IngredientsTableEwg
struct IngredientsTableEwg: Codable {
    let url: String?
    let min, max: Int?
    let data: DataEnum?
    let background: Background?
    let decision: Decision?
}

enum Background: String, Codable {
    case bgHarmful = "bg-harmful"
    case bgSafe = "bg-safe"
    case bgUnsafe = "bg-unsafe"
}

enum DataEnum: String, Codable {
    case fair = "Fair"
    case good = "Good"
    case limited = "Limited"
    case none = "None"
    case robust = "Robust"
}

enum Decision: String, Codable {
    case highHazard = "High hazard"
    case moderateHazard = "Moderate hazard"
    case safe = "Safe"
    case safeModerateHazard = "Safe - Moderate hazard"
}

// MARK: - IntegerProperties
struct IntegerProperties: Codable {
    let comedogenicRating, natural: Int?

    enum CodingKeys: String, CodingKey {
        case comedogenicRating = "comedogenic_rating"
        case natural
    }
}

// MARK: - Natural
struct Natural: Codable {
    let organic, synthetic, unknown: High?
}

// MARK: - Notable
struct Notable: Codable {
    let niacinamide, retinoid, hyaluronicAcid, aha: Aha?
    let bha, pha, antioxidant, vitamin: Aha?
    let ceramide: Aha?

    enum CodingKeys: String, CodingKey {
        case niacinamide, retinoid
        case hyaluronicAcid = "hyaluronic_acid"
        case aha, bha, pha, antioxidant, vitamin, ceramide
    }
}

// MARK: - Aha
struct Aha: Codable {
    let title: String?
    let list: [List]?
    let count: Int?
}

// MARK: - Permissions
struct Permissions: Codable {
    let canCreateProduct: Bool?

    enum CodingKeys: String, CodingKey {
        case canCreateProduct = "can_create_product"
    }
}

// MARK: - Positive
struct Positive: Codable {
    let moisturising, softening, acneFighting, antiAging: Alcohol?
    let antioxidant, whitening: Alcohol?

    enum CodingKeys: String, CodingKey {
        case moisturising, softening
        case acneFighting = "acne_fighting"
        case antiAging = "anti_aging"
        case antioxidant, whitening
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
