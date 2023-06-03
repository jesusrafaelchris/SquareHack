import UIKit

protocol LoyaltyAPICoordinatorProtocol {
    
}

class LoyaltyAPICoordinator: LoyaltyAPICoordinatorProtocol {
    
    var apiCoordinator: APICoordinatorProtocol?
    
    struct Constants {
        //static let
    }
    
    init(apiCoordinator: APICoordinatorProtocol) {
        self.apiCoordinator = apiCoordinator
    }
    
    // Create Loyalty Account
    // https://developer.squareup.com/reference/square/loyalty-api/create-loyalty-account
    // POST/v2/loyalty/accounts

    // Search Loyalty Accounts
    // https://developer.squareup.com/reference/square/loyalty-api/search-loyalty-accounts
    // POST/v2/loyalty/accounts/search

    // Retrieve Loyalty Account
    // https://developer.squareup.com/reference/square/loyalty-api/retrieve-loyalty-account
    // GET/v2/loyalty/accounts/{account_id}

    // Accumulate Loyalty Points
    // https://developer.squareup.com/reference/square/loyalty-api/accumulate-loyalty-points
    // POST/v2/loyalty/accounts/{account_id}/accumulate

    // Adjust Loyalty Points
    // https://developer.squareup.com/reference/square/loyalty-api/adjust-loyalty-points
    // POST/v2/loyalty/accounts/{account_id}/adjust

    // Search Loyalty Events
    // https://developer.squareup.com/reference/square/loyalty-api/search-loyalty-events
    // POST/v2/loyalty/events/search

    // Retrieve Loyalty Program
    // https://developer.squareup.com/reference/square/loyalty-api/retrieve-loyalty-program
    // GET/v2/loyalty/programs/{program_id}

    // Calculate Loyalty Points
    // https://developer.squareup.com/reference/square/loyalty-api/calculate-loyalty-points
    // POST/v2/loyalty/programs/{program_id}/calculate

    // List Loyalty Promotions
    // https://developer.squareup.com/reference/square/loyalty-api/list-loyalty-promotions
    // GET/v2/loyalty/programs/{program_id}/promotions

    // Create Loyalty Promotion
    // https://developer.squareup.com/reference/square/loyalty-api/create-loyalty-promotion
    // POST/v2/loyalty/programs/{program_id}/promotions

    // Retrieve Loyalty Promotion
    // https://developer.squareup.com/reference/square/loyalty-api/retrieve-loyalty-promotion
    // GET/v2/loyalty/programs/{program_id}/promotions/{promotion_id}

    // Cancel Loyalty Promotion
    // https://developer.squareup.com/reference/square/loyalty-api/cancel-loyalty-promotion
    // POST/v2/loyalty/programs/{program_id}/promotions/{promotion_id}/cancel

    // Create Loyalty Reward
    // https://developer.squareup.com/reference/square/loyalty-api/create-loyalty-reward
    // POST/v2/loyalty/rewards

    // Search Loyalty Rewards
    // https://developer.squareup.com/reference/square/loyalty-api/search-loyalty-rewards
    // POST/v2/loyalty/rewards/search

    // Delete Loyalty Reward
    // https://developer.squareup.com/reference/square/loyalty-api/delete-loyalty-reward
    // DELETE/v2/loyalty/rewards/{reward_id}

    // Retrieve Loyalty Reward
    // https://developer.squareup.com/reference/square/loyalty-api/retrieve-loyalty-reward
    // GET/v2/loyalty/rewards/{reward_id}

    // Redeem Loyalty Reward
    // https://developer.squareup.com/reference/square/loyalty-api/redeem-loyalty-reward
    // POST/v2/loyalty/rewards/{reward_id}/redeem

    
}
