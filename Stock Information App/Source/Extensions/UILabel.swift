import Foundation
import UIKit

extension UILabel {
  func configureLabel(fontSize size: CGFloat) {
    self.font = UIFont(name: "AvenirNext-Regular", size: size)
    self.textColor = UIColor.white
  }
}
