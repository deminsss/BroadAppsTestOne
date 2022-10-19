import Foundation

protocol RandomPhotoNetworkServiceProtocol {
    func getRandomPhotos(complitions: @escaping (Result<[UnsplashPhoto]?, Error>) -> ())
    func getSearchPhotos(query: String, complitions: @escaping (Result<SearchResults?, Error>) -> ())
}
    

class NetworkService: RandomPhotoNetworkServiceProtocol {
    
    func getRandomPhotos(complitions: @escaping (Result<[UnsplashPhoto]?, Error>) -> ()) {
        URLSession.shared.dataTask(with: Section.randomPhoto.URLrequest) { data, response, error in
            if let error = error {
                complitions(.failure(error))
                return
            }
            
            do {
            let obj = try JSONDecoder().decode([UnsplashPhoto].self, from: data!)
                complitions(.success(obj))
            } catch {
                complitions(.failure(error))
            }
        }.resume()
    }
    
    func getSearchPhotos(query: String, complitions: @escaping (Result<SearchResults?, Error>) -> ()) {
        URLSession.shared.dataTask(with: Section.search(query: query).URLrequest) { data, response, error in
            if let error = error {
                complitions(.failure(error))
                print(error)
                return
            }
            do {
                let obj = try JSONDecoder().decode(SearchResults.self, from: data!)
                complitions(.success(obj))
            } catch {
                complitions(.failure(error))
                print(error)

            }
        }.resume()
    }
}
