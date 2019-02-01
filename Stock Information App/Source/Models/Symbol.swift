import Alamofire
import Foundation
import RxSwift

struct Symbol {

  enum type: String, Codable {
    case REIT = "ps"
    case closedEndFund = "bo"
    case secondaryIssue = "su"
    case limitedPartnerships = "lp"
    case commonStock = "cs"
    case ETF = "et"
    case crypto = "crypto"
    case unknown = "N/A"
  }

  // MARK: Stored Property
  var symbol: String
  var name: String
  var date: String
  var isEnabled: Bool
  var symbolType: Symbol.type

  // MARK: Initializers
  init(symbol: String,
       name: String,
       date: String,
       isEnabled: Bool,
       symbolType: Symbol.type) {
        self.symbol = symbol
        self.name = name
        self.date = date
        self.isEnabled = isEnabled
        self.symbolType = symbolType
  }
}

// MARK: Codabale Methods
extension Symbol: Codable {
  enum CodingKeys: String, CodingKey {
    case symbol
    case name
    case date
    case isEnabled
    case symbolType = "type"
  }
}
