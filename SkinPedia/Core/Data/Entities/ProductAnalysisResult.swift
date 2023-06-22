// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productAnalysisResult = try? JSONDecoder().decode(ProductAnalysisResult.self, from: jsonData)

import Foundation

// MARK: - ProductAnalysisResult
struct ProductAnalysisResult: Codable {
    var analysis: Analysis?
}

// MARK: - Analysis
struct Analysis: Codable {
    var totalIngredients: Int?
    var ingredientsTable: [IngredientsTable]?
    var harmful: Harmful?
    var positive: Positive?
    var notable: Notable?
    var ewg: AnalysisEwg?
    var natural: Natural?
    var text, description, shareToken: String?
    var ingredientGroup, ownerUser: JSONNull?
    var permissions: Permissions?

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
    var unknown, low, moderate, high: High?
}

// MARK: - High
struct High: Codable {
    var count, percent: Double?
}

// MARK: - Harmful
struct Harmful: Codable {
    var allergen, alcohol, comedogenicRating, gluten: Alcohol?
    var silicone, sulfate, paraben, peg: Alcohol?
    var fungalAcneFeeding, fragrance: Alcohol?

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
    var title, description, imageURL: String?
    var itemList: [ItemList]?
    var count: Int?
    var slug: String?

    enum CodingKeys: String, CodingKey {
        case title, description
        case imageURL = "image_url"
        case itemList = "list"
        case count, slug
    }
}

// MARK: - ItemList
struct ItemList: Codable, Hashable {
    static func == (lhs: ItemList, rhs: ItemList) -> Bool {
        return lhs.title == rhs.title && lhs.alias == rhs.alias
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(alias)
    }
    
    var index: Int?
    var title, alias: String?
}

// MARK: - IngredientsTable
struct IngredientsTable: Codable, Hashable {
    static func == (lhs: IngredientsTable, rhs: IngredientsTable) -> Bool {
        return lhs.title == rhs.title && lhs.alias == rhs.alias
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(alias)
    }
    
    var index: Int?
    var title: String?
    var alias: String?
    var id: Int?
    var introtext: String?
    var cirRating: CIRRating?
    var booleanProperties: [String: Bool]?
    var integerProperties: IntegerProperties?
    var ewg: IngredientsTableEwg?
    var categories: String?

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
    var url: String?
    var min, max: Int?
    var data: DataEnum?
    var background: Background?
    var decision: Decision?
}

enum Background: String, Codable {
    case bgSafe = "bg-safe"
    case bgUnsafe = "bg-unsafe"
}

enum DataEnum: String, Codable {
    case fair = "Fair"
    case good = "Good"
    case limited = "Limited"
    case robust = "Robust"
    case none = "None"
}

enum Decision: String, Codable {
    case moderateHazard = "Moderate hazard"
    case moderateHazardHighHazard = "Moderate hazard - High hazard"
    case safe = "Safe"
    case safeModerateHazard = "Safe - Moderate hazard"
}

// MARK: - IntegerProperties
struct IntegerProperties: Codable {
    var comedogenicRating, natural: Int?

    enum CodingKeys: String, CodingKey {
        case comedogenicRating = "comedogenic_rating"
        case natural
    }
}

// MARK: - Natural
struct Natural: Codable {
    var organic, synthetic, unknown: High?
}

// MARK: - Notable
struct Notable: Codable {
    var niacinamide, retinoid, hyaluronicAcid, aha: Aha?
    var bha, pha, antioxidant, vitamin: Aha?
    var ceramide: Aha?

    enum CodingKeys: String, CodingKey {
        case niacinamide, retinoid
        case hyaluronicAcid = "hyaluronic_acid"
        case aha, bha, pha, antioxidant, vitamin, ceramide
    }
}

// MARK: - Aha
struct Aha: Codable {
    var title: String?
    var list: [JSONAny]?
    var count: Int?
}

// MARK: - Permissions
struct Permissions: Codable {
    var canCreateProduct: Bool?

    enum CodingKeys: String, CodingKey {
        case canCreateProduct = "can_create_product"
    }
}

// MARK: - Positive
struct Positive: Codable {
    var moisturising, softening, soothing, acneFighting: Alcohol?
    var antiAging, antioxidant, healing, antiseptic: Alcohol?
    var whitening, uvProtecting: Alcohol?

    enum CodingKeys: String, CodingKey {
        case moisturising, softening, soothing
        case acneFighting = "acne_fighting"
        case antiAging = "anti_aging"
        case antioxidant, healing, antiseptic, whitening
        case uvProtecting = "uv_protecting"
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

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

