import UIKit

enum CatalogObjectType: String, Codable {
    case item = "ITEM"
    case image = "IMAGE"
    case category = "CATEGORY"
    case itemVariation = "ITEM_VARIATION"
    case tax = "TAX"
    case discount = "DISCOUNT"
    case modifierList = "MODIFIER_LIST"
    case modifier = "MODIFIER"
    case pricingRule = "PRICING_RULE"
    case productSet = "PRODUCT_SET"
    case timePeriod = "TIME_PERIOD"
    case measurementUnit = "MEASUREMENT_UNIT"
    case itemOption = "ITEM_OPTION"
    case itemOptionValue = "ITEM_OPTION_VAL"
    case customAttributeDefinition = "CUSTOM_ATTRIBUTE_DEFINITION"
    case quickAmountsSettings = "QUICK_AMOUNTS_SETTINGS"
    case subscriptionPlan = "SUBSCRIPTION_PLAN"
}

