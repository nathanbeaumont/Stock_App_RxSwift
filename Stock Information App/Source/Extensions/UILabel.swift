import Foundation
import UIKit

extension UILabel {
  func configureLabel(fontSize size: CGFloat) {
    configureLabel(fontSize: size, textColor: .white)
  }

  func configureLabel(fontSize size: CGFloat, textColor: UIColor) {
    self.font = UIFont(name: "AvenirNext-Regular", size: size)
    self.textColor = textColor
  }
}
