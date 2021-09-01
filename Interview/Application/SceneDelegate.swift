import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            let module = assembleFirstModule()
            startModule(module: module)
        }
    }
}

// MARK: Modules
extension SceneDelegate {

    func assembleFirstModule() -> UIViewController {
        ListContactsViewAssembler.assemble()
    }

    func startModule(module: UIViewController) {
        self.window?.rootViewController = UINavigationController(rootViewController: module)
        self.window?.makeKeyAndVisible()
    }
}
