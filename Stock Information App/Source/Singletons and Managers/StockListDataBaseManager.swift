import Foundation

final class StockListDataBaseManager {

  static let shared = StockListDataBaseManager()

  lazy var plistPath: String = {
    let plistFileName = "Stock_List.plist"
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentPath = paths[0] as NSString
    let plistPath = documentPath.appendingPathComponent(plistFileName)

    return plistPath
  }()

  public func addStock(symbol ticker: String) {
    if FileManager.default.fileExists(atPath: plistPath) {
      let stocks = NSMutableArray(contentsOfFile: plistPath) ?? NSMutableArray()
      stocks.add(ticker)
      stocks.write(toFile: plistPath, atomically: true)
    }
  }

  public func getSavedStocks() -> [String] {
    if FileManager.default.fileExists(atPath: plistPath) {
      if let stocks = NSArray(contentsOfFile: plistPath) {
        for (_, element) in stocks.enumerated() {
         print(element)
        }
      }
    }

    return []
  }
}
