import Foundation
import UIKit

extension UIFont {
  struct Custom {
    public static var avenirFont: UIFont {
      return UIFont(name: "AvenirNext-Regular", size: 17.0)!
    }

    public static func avenirFont(fontsize: CGFloat) -> UIFont {
      return UIFont(name: "AvenirNext-Regular", size: fontsize)!
    }

    public static func avenirFontBold(fontsize: CGFloat) -> UIFont {
      return UIFont(name: "AvenirNext-Bold", size: fontsize)!
    }
  }
}
