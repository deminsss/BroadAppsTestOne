
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let tabBarController = UITabBarController()
        let navigationController = UINavigationController()
        let assamblyBuilder = AssemblyModuleBuilder()
        let router = Router(tabBarController: tabBarController, navigationController: navigationController, assamblyBuilder: assamblyBuilder)
        router.initionalViewController()
 
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

    //        tabBarController.tabBar.backgroundColor = .white
    //        tabBarController.tabBar.tintColor = .black
    //        tabBarController.viewControllers = [RandomPhotoVC]
    //        RandomPhotoVC.tabBarItem = UITabBarItem(title: "Search",
    //                                            image: UIImage(named: "camera"),
    //                                            selectedImage: UIImage(named: "camera"))

    
}

