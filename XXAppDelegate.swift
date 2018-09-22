import UIKit

@UIApplicationMain
class XXAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var rootViewController: UINavigationController?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: UIScreen.main.bounds)
        rootViewController = UINavigationController(rootViewController: XXRootViewController())
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}