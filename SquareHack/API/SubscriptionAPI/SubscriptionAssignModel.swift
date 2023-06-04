import Foundation

struct SubscriptionAssignModel: Codable {
    let idempotencyKey: String
    let locationID: String
    let planID: String
    let customerID: String

    enum CodingKeys: String, CodingKey {
        case idempotencyKey = "idempotency_key"
        case locationID = "location_id"
        case planID = "plan_id"
        case customerID = "customer_id"
    }
}
