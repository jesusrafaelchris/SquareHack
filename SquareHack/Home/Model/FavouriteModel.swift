import Foundation

struct FavouriteModel: Codable {
    var image: String?
    var logo: String?
    var name: String
    var type: String
    var hasOffer: Bool
    var latitude: Double
    var longitude: Double
}
