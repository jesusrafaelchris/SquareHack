import UIKit

struct CatalogObjectModel: Codable {
    let idempotencyKey: String?
    let object: Object?

    private enum CodingKeys: String, CodingKey {
        case idempotencyKey = "idempotency_key"
        case object
    }
}

struct Object: Codable {
    let type: String?
    let itemData: ItemData?
    let id: String?

    private enum CodingKeys: String, CodingKey {
        case type
        case itemData = "item_data"
        case id
    }
}

struct ItemData: Codable {
    let abbreviation: String?
    let name: String?
    let variations: [Variation]?

    private enum CodingKeys: String, CodingKey {
        case abbreviation
        case name
        case variations
    }
}

struct Variation: Codable {
    let id: String?
    let type: String?
    let itemVariationData: ItemVariationData?

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case itemVariationData = "item_variation_data"
    }
}

struct ItemVariationData: Codable {
    let name: String?
    let pricingType: String?
    let priceMoney: PriceMoney?

    private enum CodingKeys: String, CodingKey {
        case name
        case pricingType = "pricing_type"
        case priceMoney = "price_money"
    }
}

struct PriceMoney: Codable {
    let amount: Int?
    let currency: String?

    private enum CodingKeys: String, CodingKey {
        case amount
        case currency
    }
}
