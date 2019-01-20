import Alamofire
import Foundation
import RxSwift

struct Stock {

  // MARK: Stored Properties
  var averageVolume: Int
  var changePrice: Float
  var changePricePercent: Float
  var closePrice: Float
  var companyName: String
  var industrySector: String
  var fiftyTwoWeekHigh: Float
  var fiftyTwoWeekLow: Float
  var highPriceOfDay: Float
  var latestPrice: Float
  var lastTimeUpdate: String
  var lowPriceOfDay: Float
  var marketCap: Int
  var openPrice: Float
  var PERatio: Float
  var symbol: String

  init(averageVolume: Int,
       changePrice: Float,
       changePricePercent: Float,
       closePrice: Float,
       companyName: String,
       industrySector: String,
       fiftyTwoWeekHigh: Float,
       fiftyTwoWeekLow: Float,
       highPriceOfDay: Float,
       latestPrice: Float,
       lastTimeUpdate: String,
       lowPriceOfDay: Float,
       marketCap: Int,
       openPrice: Float,
       PERatio: Float,
       symbol: String) {
        self.averageVolume = averageVolume
        self.changePrice = changePrice
        self.changePricePercent = changePricePercent
        self.closePrice = closePrice
        self.companyName = companyName
        self.industrySector = industrySector
        self.fiftyTwoWeekHigh = fiftyTwoWeekHigh
        self.fiftyTwoWeekLow = fiftyTwoWeekLow
        self.highPriceOfDay = highPriceOfDay
        self.latestPrice = latestPrice
        self.lastTimeUpdate = lastTimeUpdate
        self.lowPriceOfDay = lowPriceOfDay
        self.marketCap = marketCap
        self.openPrice = openPrice
        self.PERatio = PERatio
        self.symbol = symbol
  }
}

// MARK: Codabale Methods
extension Stock: Codable {
  enum CodingKeys: String, CodingKey {
    case averageVolume = "avgTotalVolume"
    case changePrice = "change"
    case changePricePercent = "changePercent"
    case closePrice = "close"
    case companyName
    case industrySector = "sector"
    case fiftyTwoWeekHigh = "week52High"
    case fiftyTwoWeekLow = "week52Low"
    case highPriceOfDay = "high"
    case latestPrice
    case lastTimeUpdate = "latestTime"
    case lowPriceOfDay = "low"
    case marketCap
    case openPrice = "open"
    case PERatio = "peRatio"
    case symbol
  }
}
