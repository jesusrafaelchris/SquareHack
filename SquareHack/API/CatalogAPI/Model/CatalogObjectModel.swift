import UIKit

struct CatalogObjectModel: Codable {
    let idempotencyKey: String
    let object: Object
}

struct Object: Codable {
    let type: String
    let itemData: ItemData
    let id: String
}

struct ItemData: Codable {
    let abbreviation: String
    let name: String
    let variations: [Variation]
}

struct Variation: Codable {
    let id: String
    let type: String
    let itemVariationData: ItemVariationData
}

struct ItemVariationData: Codable {
    let name: String
    let pricingType: String
    let priceMoney: PriceMoney
}

struct PriceMoney: Codable {
    let amount: Int
    let currency: String
}


