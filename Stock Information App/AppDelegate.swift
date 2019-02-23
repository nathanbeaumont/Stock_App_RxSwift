import Toast_Swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    styleToast()

    return true
  }


  private func styleToast() {
    ToastManager.shared.position = .center
    ToastManager.shared.style.titleAlignment = .center
    ToastManager.shared.style.messageAlignment = .center
    ToastManager.shared.style.titleColor = UIColor.white
    ToastManager.shared.style.messageColor = UIColor.white
    ToastManager.shared.duration = 1.5
  }
}

