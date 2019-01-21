import UIKit
import Foundation

extension UIColor {
  struct Custom {
    static var lightBlue: UIColor {
      return UIColor(red: 0, green: 189, blue: 228, alpha: 1.0)
    }

    static var mediumBlue: UIColor {
      return UIColor(red: 0, green: 161, blue: 228, alpha: 1.0)
    }
  }

  convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
     self.init(red: CGFloat(red) / 255.0,
               green: CGFloat(green) / 255.0,
               blue: CGFloat(blue) / 255.0,
               alpha: alpha)
  }
}
