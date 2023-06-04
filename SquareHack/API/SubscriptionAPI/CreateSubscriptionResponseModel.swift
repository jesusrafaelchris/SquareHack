import Foundation

struct CreateSubscriptionResponseModel: Codable {
    let id: String
    let locationID: String
    let planID: String
    let customerID: String
    let startDate: String
    let status: String
    let version: Int
    let createdAt: String
    let timezone: String

    enum CodingKeys: String, CodingKey {
        case id
        case locationID = "location_id"
        case planID = "plan_id"
        case customerID = "customer_id"
        case startDate = "start_date"
        case status
        case version
        case createdAt = "created_at"
        case timezone
    }
}
