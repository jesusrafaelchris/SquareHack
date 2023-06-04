import Foundation

enum PlanCadence: String, Codable {
    case daily = "DAILY"
    case weekly = "WEEKLY"
    case everyTwoWeeks = "EVERY_TWO_WEEKS"
    case thirtyDays = "THIRTY_DAYS"
    case sixtyDays = "SIXTY_DAYS"
    case ninetyDays = "NINETY_DAYS"
    case monthly = "MONTHLY"
    case everyTwoMonths = "EVERY_TWO_MONTHS"
    case quarterly = "QUARTERLY"
    case everyFourMonths = "EVERY_FOUR_MONTHS"
    case everySixMonths = "EVERY_SIX_MONTHS"
    case annual = "ANNUAL"
    case everyTwoYears = "EVERY_TWO_YEARS"
    
    var description: String {
        switch self {
        case .daily:
            return "Once per day"
        case .weekly:
            return "Once per week"
        case .everyTwoWeeks:
            return "Every two weeks"
        case .thirtyDays:
            return "Once every 30 days"
        case .sixtyDays:
            return "Once every 60 days"
        case .ninetyDays:
            return "Once every 90 days"
        case .monthly:
            return "Once per month"
        case .everyTwoMonths:
            return "Once every two months"
        case .quarterly:
            return "Once every three months"
        case .everyFourMonths:
            return "Once every four months"
        case .everySixMonths:
            return "Once every six months"
        case .annual:
            return "Once per year"
        case .everyTwoYears:
            return "Once every two years"
        }
    }
}
