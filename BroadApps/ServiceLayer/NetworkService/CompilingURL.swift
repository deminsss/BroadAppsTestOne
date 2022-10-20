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
    //MARK: - Generate URL(RandomPhoto module)
    var URLrequest: URLRequest {
        var request = URLRequest(url: urlComponents)
        request.httpMethod = "GET"
        var header = [String: String]()
        header["Authorization"] = "Client-ID x259sosyrpvGiCk8e-5KehGZdz63ehssYPyurd4vb1w"
        request.allHTTPHeaderFields = header
        return request
    }
}
