import UIKit

struct CatalogSearchModel: Codable {
    let objects: [CatalogItemObject]?
    let latestTime: String?
    
    enum CodingKeys: String, CodingKey {
        case objects, latestTime = "latest_time"
    }
}

struct CatalogItemObject: Codable {
    let type: String?
    let id: String?
    let updatedAt: String?
    let createdAt: String?
    let version: Int?
    let isDeleted: Bool?
    let presentAtAllLocations: Bool?
    let itemData: CatalogItemData?
    
    enum CodingKeys: String, CodingKey {
        case type, id, updatedAt = "updated_at", createdAt = "created_at", version, isDeleted = "is_deleted", presentAtAllLocations = "present_at_all_locations", itemData = "item_data"
    }
}

struct CatalogItemData: Codable {
    let name: String?
    let abbreviation: String?
    let isTaxable: Bool?
    let variations: [CatalogVariation]?
    let productType: String?
    let visibility: String?
    let availableOnline: Bool?

    enum CodingKeys: String, CodingKey {
        case name, abbreviation
        case isTaxable = "is_taxable"
        case variations
        case productType = "product_type"
        case visibility
        case availableOnline = "available_online"
    }
}

struct CatalogVariation: Codable {
    let type: String?
    let id: String?
    let updatedAt: String?
    let createdAt: String?
    let version: Int?
    let isDeleted: Bool?
    let presentAtAllLocations: Bool?
    let itemVariationData: CatalogItemVariationData?
    
    enum CodingKeys: String, CodingKey {
        case type, id, updatedAt = "updated_at", createdAt = "created_at", version, isDeleted = "is_deleted", presentAtAllLocations = "present_at_all_locations", itemVariationData = "item_variation_data"
    }
}

struct CatalogItemVariationData: Codable {
    let itemId: String?
    let name: String?
    let ordinal: Int?
    let pricingType: String?
    let priceMoney: CatalogPriceMoney?
    let sellable: Bool?
    let stockable: Bool?
    
    enum CodingKeys: String, CodingKey {
        case itemId = "item_id", name, ordinal, pricingType = "pricing_type", priceMoney = "price_money", sellable, stockable
    }
}

struct CatalogPriceMoney: Codable {
    let amount: Int?
    let currency: String?
}
