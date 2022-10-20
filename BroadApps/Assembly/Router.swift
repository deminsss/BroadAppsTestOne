import Foundation
import UIKit

protocol RouterMainProtocol {
    var assemblyBuilder: AssemblyBuilder? {get set}
    var tabBarController: UITabBarController? {get set}
}

protocol RouterProtocol: RouterMainProtocol {
    func initionalViewController()
    func showDetail(navigationController: UINavigationController, photos: UnsplashPhoto?)
}

class Router: RouterProtocol {

    var tabBarController: UITabBarController?
    var assemblyBuilder: AssemblyBuilder?
    
    init(tabBarController: UITabBarController?, assamblyBuilder: AssemblyBuilder?) {
        self.tabBarController = tabBarController
        self.assemblyBuilder = assamblyBuilder
    }
    
    func initionalViewController() {
        guard let tabBarController = tabBarController else { return }
        guard let randomPhotoVC = assemblyBuilder?.createRandomPhotoModule(router: self) else { return }
        guard let likedPhotoVC = assemblyBuilder?.createLikedPhotoModule(router: self) else { return }
        let randomPhotoViewConroller = createViewConreoller(rootViewController: randomPhotoVC,
                                                            title: "Photos",
                                                            image: UIImage(named: "camera")!)
        let likedPhotoViewController = createViewConreoller(rootViewController: likedPhotoVC,
                                                            title: "Favorites",
                                                            image: UIImage(named: "heart")!)
        
        tabBarController.viewControllers = [randomPhotoViewConroller, likedPhotoViewController]
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.tintColor = .black
    }
    
    func showDetail(navigationController: UINavigationController,photos: UnsplashPhoto?) {
        guard let detailViewController = assemblyBuilder?.createDetailPhotoModule(router: self, photo: photos) else { return }
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    private func createViewConreoller(rootViewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem = UITabBarItem(title: title,
                                                       image: image,
                                                       selectedImage: image)
        return navigationController
    }
    
}

