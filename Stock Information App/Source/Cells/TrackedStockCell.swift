import UIKit

class TrackedStockCell: UITableViewCell {

  @IBOutlet var allLabels: [UILabel]!

  // MARK: Left Stackview outlets
  @IBOutlet weak var symbolLabel: UILabel!
  @IBOutlet weak var companyNameLabel: UILabel!
  @IBOutlet weak var latestPrice: UILabel!

  // MARK: Right Stackview outlets
  @IBOutlet weak var fiftyTwoWeekHighLabel: UILabel!
  @IBOutlet weak var fiftyTwoWeekLowLabel: UILabel!
  @IBOutlet weak var priceToEarningsLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    for label in allLabels {
      label.configureLabel(fontSize: 16.0, textColor: UIColor.darkGray)
    }
  }

  // MARK: Public Methods

  public func configureStockCell(stock: Stock) {
    symbolLabel.text = stock.symbol
    companyNameLabel.text = stock.companyName
    latestPrice.text = "$\(stock.latestPrice)"

    fiftyTwoWeekHighLabel.text = "52 Week High: \(stock.fiftyTwoWeekHigh)"
    fiftyTwoWeekLowLabel.text = "52 Week High: \(stock.fiftyTwoWeekLow)"
    priceToEarningsLabel.text = (stock.PERatio != nil) ? "PE Ratio: \(stock.PERatio!)" : ""
  }
}
