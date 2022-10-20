import Foundation
import UIKit

//MARK: - View protocol

protocol RandomPhotoViewProtocol: AnyObject {
    func sucess()
    func failure(error: Error)
}

//MARK: - Presenter protocol

protocol RandomPhotoPresenterProtocol: AnyObject {
    init( view: RandomPhotoViewProtocol, networkService: RandomPhotoNetworkServiceProtocol, router: RouterProtocol)
    var photosResult: [UnsplashPhoto]? {get set}
    func getRandomPhoto()
    func getSearchPhoto(query: String)
    func tapOnThePhoto(navigationConroller: UINavigationController, info: UnsplashPhoto?)
    func numberOfItems(in section: Int) -> Int
    func getPhotoUrl(for indexpath : Int) -> String?
}

final class RandomPhotoPresenter: RandomPhotoPresenterProtocol {
    
    //MARK: - Presenter property
    
    var photosResult: [UnsplashPhoto]?
    var router: RouterProtocol?
    weak var view: RandomPhotoViewProtocol!
    var networkService: RandomPhotoNetworkServiceProtocol!
    
    //MARK: - Presenter init
    
    required init(view: RandomPhotoViewProtocol, networkService: RandomPhotoNetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getRandomPhoto()
    }
    
    //MARK: - Get random photo method
    
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
    
    //MARK: - Get a photo after the search method
    
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
    
    //MARK: - Push navigation pethod
    
    func tapOnThePhoto(navigationConroller: UINavigationController, info: UnsplashPhoto?) {
        router?.showDetail(navigationController: navigationConroller, info: info)
    }
    
    //MARK: - Number of items method
    
    func numberOfItems(in section: Int) -> Int {
        return photosResult?.count ?? 0
    }
    
    //MARK: - Get photo url method
    
    func getPhotoUrl(for indexpath : Int) -> String? {
        return photosResult?[indexpath].urls.small
    }
}

