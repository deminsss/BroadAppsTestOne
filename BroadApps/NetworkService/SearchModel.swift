import Foundation

struct SearchResults: Decodable {
    var results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    var created_at: String
    var urls: PhotoURL
    var location: LocationName?
    var user : Userbio?
    var downloads: Int
}

struct PhotoURL: Decodable {
    var small: String?
}

struct LocationName: Decodable {
    var name: String?
}

struct Userbio : Decodable {
    var name: String?
}
