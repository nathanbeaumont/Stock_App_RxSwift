import Foundation

enum AddStockError: Int {
  case none = 0
  case stockAlreadyAdded = 1
  case fileWrite = 2
}

final class StockListDataBaseManager {

  static let shared = StockListDataBaseManager()

  private init() {
    createPlistInDocumentsIfNeeded()
  }

  lazy var plistPathInDocument: String = {
      let rootPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                         .userDomainMask, true)[0]
      return rootPath.appendingFormat("Stock_List.plist")
  }()

  public func addStock(symbol ticker: String) -> AddStockError {
    guard FileManager.default.fileExists(atPath: plistPathInDocument),
      let stockList = NSMutableArray(contentsOfFile: plistPathInDocument) else {
        return .fileWrite
    }

    guard !stockList.contains(ticker) else {
      return .stockAlreadyAdded
    }

    stockList.add(ticker)
    if stockList.write(toFile: plistPathInDocument, atomically: true) {
      return .none
    }

    return .fileWrite
  }

  public func getSavedStocks() -> [String] {
    if FileManager.default.fileExists(atPath: plistPathInDocument),
      let stockList = NSMutableArray(contentsOfFile: plistPathInDocument) {
        return stockList as! [String]
    }

    return []
  }

  public func createPlistInDocumentsIfNeeded() {
    if !FileManager.default.fileExists(atPath: plistPathInDocument) {
      let plistPathInBundle = Bundle.main.path(forResource: "Stock_List", ofType: "plist")!
      // 3
      do {
        try FileManager.default.copyItem(atPath: plistPathInBundle, toPath: plistPathInDocument)
      } catch {
        print("Error occurred while copying file to document \(error)")
      }
    }
  }
}
