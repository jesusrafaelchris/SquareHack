import Foundation

struct SubscriptionPlanModel: Codable {
    let idempotencyKey: String
    let object: PlanObject
}

struct PlanObject: Codable {
    let type: String
    let id: String
    let subscriptionPlanData: SubscriptionPlanData2

    private enum CodingKeys: String, CodingKey {
        case type, id
        case subscriptionPlanData = "subscription_plan_data"
    }
}

struct SubscriptionPlanData2: Codable {
    let name: String
    let phases: [SubscriptionPlanPhase]
}

struct SubscriptionPlanPhase: Codable {
    let cadence: String
    let periods: Int?
    let recurringPriceMoney: SubscriptionPriceMoney

    private enum CodingKeys: String, CodingKey {
        case cadence, periods
        case recurringPriceMoney = "recurring_price_money"
    }
}

struct SubscriptionPriceMoney: Codable {
    let amount: Int
    let currency: String
}
