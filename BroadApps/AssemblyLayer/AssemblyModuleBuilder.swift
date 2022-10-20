import UIKit

//MARK: - Builder protocol

protocol AssemblyBuilder {
    func createRandomPhotoModule(router: RouterProtocol) -> UIViewController
    func createDetailPhotoModule(router: RouterProtocol, photo: UnsplashPhoto?) -> UIViewController
    func createLikedPhotoModule(router: RouterProtocol) -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyBuilder {
   
    //MARK: - Create random photo module

    func createRandomPhotoModule(router: RouterProtocol) -> UIViewController {
        let view = RandomPhotoViewController()
        let networkService = NetworkService()
        let presenter = RandomPhotoPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    //MARK: - Create liked photo module

    func createLikedPhotoModule(router: RouterProtocol) -> UIViewController {
        let view = LikedPhotoViewController()
        let realm = RealmManager()
        let presenter = LikedPhotoPresenter(view: view, realm: realm)
        view.presenter = presenter
        return view
    }
    
    //MARK: - Create detail photo module

    func createDetailPhotoModule(router: RouterProtocol, photo: UnsplashPhoto?) -> UIViewController {
        let view = DetailPhotoViewController()
        let realm = RealmManager()
        let presenter = DetailPhotoPresenter(view: view, photo: photo, realm: realm)
        view.presenter = presenter
        return view
    }
}
