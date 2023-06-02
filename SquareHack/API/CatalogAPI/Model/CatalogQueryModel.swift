import UIKit

struct CatalogQueryModel: Codable {
    let exactQuery: ExactQuery
    
    enum CodingKeys: String, CodingKey {
        case exactQuery = "exact_query"
    }
}

struct ExactQuery: Codable {
    let attributeName: String
    let attributeValue: String
    
    enum CodingKeys: String, CodingKey {
        case attributeName = "attribute_name"
        case attributeValue = "attribute_value"
    }
}
