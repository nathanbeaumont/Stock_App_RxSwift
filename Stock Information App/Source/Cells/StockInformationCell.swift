import UIKit

class StockInformationCell: UITableViewCell {

  @IBOutlet weak var companyNameLabel: UILabel!
  @IBOutlet weak var stockTickerLable: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    companyNameLabel.font = UIFont.Custom.avenirFont
    stockTickerLable.font = UIFont.Custom.avenirFont
  }
}
