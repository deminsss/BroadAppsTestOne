import Foundation
import UIKit

protocol RouterMainProtocol {
    var assemblyBuilder: AssemblyBuilder? {get set}
    var tabBarController: UITabBarController? {get set}
    var navigationController: UINavigationController? {get set}
}

protocol RouterProtocol: RouterMainProtocol {
    func initionalViewController()
    func showDetail(photos: UnsplashPhoto?)
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var tabBarController: UITabBarController?
    var assemblyBuilder: AssemblyBuilder?
    
    init(tabBarController: UITabBarController?, navigationController: UINavigationController?, assamblyBuilder: AssemblyBuilder?) {
        self.tabBarController = tabBarController
        self.assemblyBuilder = assamblyBuilder
    }
    
    func initionalViewController() {
        let navigationController = UINavigationController()
        print(tabBarController?.navigationController)
        guard let tabBarController = tabBarController else { return }
        guard let randomPhotoViewController = assemblyBuilder?.createRandomPhotoModule(router: self) else { return }
        navigationController.viewControllers = [randomPhotoViewController]
        print(tabBarController.navigationController)
        guard let likedPhotoViewController = assemblyBuilder?.createLikedPhotoModule(router: self) else { return }
        tabBarController.viewControllers = [navigationController, likedPhotoViewController]
        print(tabBarController.navigationController)
        print(tabBarController)
    }
    
    func showDetail(photos: UnsplashPhoto?) {
        guard let detailViewController = assemblyBuilder?.createDetailPhotoModule(router: self, photo: photos) else { return }
        tabBarController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
