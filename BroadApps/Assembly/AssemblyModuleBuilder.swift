import UIKit
//MARK: - Builder protocol

protocol AssemblyBuilder {
    func createRandomPhotoModule(router: RouterProtocol) -> UIViewController
    func createDetailPhotoModule(router: RouterProtocol, photo: UnsplashPhoto?) -> UIViewController
    func createLikedPhotoModule(router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilder {
   
    func createRandomPhotoModule(router: RouterProtocol) -> UIViewController {
        let view = RandomPhotoViewController()
        let networkService = NetworkService()
        let presenter = RandomPhotoPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createLikedPhotoModule(router: RouterProtocol) -> UIViewController {
        let view = LikedPhotoViewController()
        let presenter = LikedPhotoPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createDetailPhotoModule(router: RouterProtocol, photo: UnsplashPhoto?) -> UIViewController {
        let view = DetailPhotoViewController()
        let presenter = DetailPhotoPresenter(view: view, photo: photo)
        view.presenter = presenter
        return view
    }
}
