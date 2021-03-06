#if os(iOS)

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var presenter: AppPresenter?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let (window, presenter) = AppPresenter.bootstrap()

        self.window = window
        self.presenter = presenter

        return true
    }
}

#endif
