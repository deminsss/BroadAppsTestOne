import Foundation

protocol RandomPhotoViewProtocol: AnyObject {
    func sucess()
    func failure(error: Error)
}

protocol RandomPhotoPresenterProtocol: AnyObject {
    init( view: RandomPhotoViewProtocol, networkService: RandomPhotoNetworkServiceProtocol, router: RouterProtocol)
    var photosResult: [UnsplashPhoto]? {get set}
    func getRandomPhoto()
    func getSearchPhoto(query: String)
    func tapOnThePhoto(photo: UnsplashPhoto?)
}

class RandomPhotoPresenter: RandomPhotoPresenterProtocol {
    
    var photosResult: [UnsplashPhoto]?
    var router: RouterProtocol?
    weak var view: RandomPhotoViewProtocol!
    var networkService: RandomPhotoNetworkServiceProtocol!
    
    required init(view: RandomPhotoViewProtocol, networkService: RandomPhotoNetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getRandomPhoto()
    }
    
    func getRandomPhoto() {
        networkService.getRandomPhotos { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let photosResult):
                    self.photosResult = photosResult
                    self.view?.sucess()
                case .failure(let error):
                    self.view?.failure(error: error)
                    print(error)
                }
            }
        }
    }
    
    func getSearchPhoto(query: String) {
        networkService.getSearchPhotos(query: query) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let photosResult):
                    self.photosResult = photosResult?.results
                    self.view?.sucess()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func tapOnThePhoto(photo: UnsplashPhoto?) {
        router?.showDetail(photos: photo)
    }
}

