import Foundation

struct CustomerModel: Codable {
    var givenName: String
    var familyName: String
    var emailAddress: String

    enum CodingKeys: String, CodingKey {
        case givenName = "given_name"
        case familyName = "family_name"
        case emailAddress = "email_address"
    }
}

