import Foundation
import UIKit

//MARK: - Router main protocol

protocol RouterMainProtocol {
    var assemblyBuilder: AssemblyBuilder? {get set}
    var tabBarController: UITabBarController? {get set}
}

//MARK: - Router protocol

protocol RouterProtocol: RouterMainProtocol {
    func initionalViewController()
    func showDetail(navigationController: UINavigationController, photos: UnsplashPhoto?)
}

//MARK: - Router protocol


final class Router: RouterProtocol {
    
    //MARK: - Property

    var tabBarController: UITabBarController?
    var assemblyBuilder: AssemblyBuilder?
    
    //MARK: - Router init

    init(tabBarController: UITabBarController?, assamblyBuilder: AssemblyBuilder?) {
        self.tabBarController = tabBarController
        self.assemblyBuilder = assamblyBuilder
    }
    
    //MARK: - Initional method

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
    
    //MARK: - Show detail viewcontroller method

    func showDetail(navigationController: UINavigationController, photos: UnsplashPhoto?) {
        guard let detailViewController = assemblyBuilder?.createDetailPhotoModule(router: self,
                                                                                  photo: photos) else { return }
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    //MARK: - Create viewcontrollers to tabbar controller

    private func createViewConreoller(rootViewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem = UITabBarItem(title: title,
                                                       image: image,
                                                       selectedImage: image)
        return navigationController
    }
}

