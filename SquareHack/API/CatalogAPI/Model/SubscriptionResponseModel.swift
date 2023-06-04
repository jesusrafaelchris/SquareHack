import Foundation

struct SubscriptionPlanResponse: Codable {
    let catalogObject: SubscriptionCatalogObject
    let idMappings: [SubscriptionIdMapping]

    enum CodingKeys: String, CodingKey {
        case catalogObject = "catalog_object"
        case idMappings = "id_mappings"
    }
}

struct SubscriptionPlanData: Codable {
    let name: String
    let phases: [Phase]
}

struct Phase: Codable {
    let uid: String
    let cadence: PlanCadence
    let periods: Int?
    let recurringPriceMoney: SubscriptionPriceMoney
    let ordinal: Int
}

struct SubscriptionCatalogObject: Codable {
    let type: String
    let id: String
    let updatedAt: String
    let version: Int
    let isDeleted: Bool
    let presentAtAllLocations: Bool
    let subscriptionPlanData: SubscriptionPlanData

    enum CodingKeys: String, CodingKey {
        case type, id
        case updatedAt = "updated_at"
        case version
        case isDeleted = "is_deleted"
        case presentAtAllLocations = "present_at_all_locations"
        case subscriptionPlanData = "subscription_plan_data"
    }
}

struct SubscriptionIdMapping: Codable {
    let clientObjectId: String
    let objectId: String

    enum CodingKeys: String, CodingKey {
        case clientObjectId = "client_object_id"
        case objectId = "object_id"
    }
}

struct ReturnSubscriptionData {
    var name: String
    var uid: String
    var price: Int
}
