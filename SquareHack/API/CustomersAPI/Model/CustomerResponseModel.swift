import Foundation

struct CustomerReponseModel: Codable {
    let customer: Customer
}

struct Customer: Codable {
    let id: String
    let createdAt: String
    let updatedAt: String
    let givenName: String
    let familyName: String
    let emailAddress: String
    let preferences: Preferences
    let creationSource: String
    let version: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case givenName = "given_name"
        case familyName = "family_name"
        case emailAddress = "email_address"
        case preferences
        case creationSource = "creation_source"
        case version
    }
}

struct Preferences: Codable {
    let emailUnsubscribed: Bool
    
    enum CodingKeys: String, CodingKey {
        case emailUnsubscribed = "email_unsubscribed"
    }
}

