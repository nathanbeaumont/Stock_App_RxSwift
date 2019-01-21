import Foundation
import RxCocoa
import UIKit

extension UINavigationController {
  class func navigationControllerForModallyPresented(view viewController: UIViewController) -> UINavigationController {
    let doneButton = UIBarButtonItem(title: "Done", style: .done, target: viewController, action: nil)
    viewController.navigationItem.rightBarButtonItem = doneButton
    viewController.navigationItem.rightBarButtonItem?.tintColor = UIColor.white

    let navigationController = UINavigationController(rootViewController: viewController)
    navigationController.navigationBar.barTintColor = UIColor.Custom.lightBlue

    return navigationController
  }
}
