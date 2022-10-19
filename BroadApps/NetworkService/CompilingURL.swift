import Foundation
//MARK: - Generate URL(RandomPhoto module)
enum Section {
    case randomPhoto
    case search (query: String)
    
    private var urlComponents: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        
        switch self {
        case .randomPhoto:
            components.path = "/photos/random"
            components.queryItems = [URLQueryItem(name: "count", value: String(30))]
            
        case .search(query: let query):
            components.path = "/search/photos"
            components.queryItems = [URLQueryItem(name: "query", value: query),
                                     URLQueryItem(name: "count", value: String(30)),
            ]
        }
        return components.url!
    }
    
    var URLrequest: URLRequest {
        var request = URLRequest(url: urlComponents)
        request.httpMethod = "GET"
        var header = [String: String]()
        header["Authorization"] = "Client-ID RlUaOym7xx68mi99YKMBiNMS5mBjObVe_cJ8UBjqAaE"
        request.allHTTPHeaderFields = header
        return request
    }
}
