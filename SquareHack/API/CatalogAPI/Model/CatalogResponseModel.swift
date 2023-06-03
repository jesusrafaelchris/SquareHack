import Foundation

struct CatalogResponseModel: Codable {
    let catalog_object: CatalogObject
    let id_mappings: [CatalogResponseIdMapping]

    private enum CodingKeys: String, CodingKey {
        case catalog_object, id_mappings
    }
}

struct CatalogObject: Codable {
    let type: String
    let id: String
    let updated_at: String
    let created_at: String
    let version: Int
    let is_deleted: Bool
    let present_at_all_locations: Bool
    let item_data: CatalogResponseItemData

    private enum CodingKeys: String, CodingKey {
        case type, id, updated_at, created_at, version, is_deleted, present_at_all_locations, item_data
    }
}

struct CatalogResponseItemData: Codable {
    let name: String
    let abbreviation: String
    let is_taxable: Bool
    let variations: [CatalogResponseItemVariation]
    let product_type: String

    private enum CodingKeys: String, CodingKey {
        case name, abbreviation, is_taxable, variations, product_type
    }
}

struct CatalogResponseItemVariation: Codable {
    let type: String
    let id: String
    let updated_at: String
    let created_at: String
    let version: Int
    let is_deleted: Bool
    let present_at_all_locations: Bool
    let item_variation_data: CatalogResponseItemVariationData

    private enum CodingKeys: String, CodingKey {
        case type, id, updated_at, created_at, version, is_deleted, present_at_all_locations, item_variation_data
    }
}

struct CatalogResponseItemVariationData: Codable {
    let item_id: String
    let name: String
    let ordinal: Int
    let pricing_type: String
    let price_money: CatalogResponsePriceMoney
    let sellable: Bool
    let stockable: Bool

    private enum CodingKeys: String, CodingKey {
        case item_id, name, ordinal, pricing_type, price_money, sellable, stockable
    }
}

struct CatalogResponsePriceMoney: Codable {
    let amount: Int
    let currency: String

    private enum CodingKeys: String, CodingKey {
        case amount, currency
    }
}

struct CatalogResponseIdMapping: Codable {
    let client_object_id: String
    let object_id: String

    private enum CodingKeys: String, CodingKey {
        case client_object_id, object_id
    }
}
