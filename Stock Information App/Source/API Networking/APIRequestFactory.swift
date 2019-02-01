import Alamofire
import Foundation
import RxSwift

struct APIRequestFactory {
  static func stock(tickerSymbol: String) -> APIRequest<Stock> {
    return APIRequest.init(host: APIRequest<Stock>.Constants.IEXHostName,
                           methodType: HTTPMethod.get,
                           path: "1.0/stock/\(tickerSymbol)/quote",
                           modelClass: Stock.self)
  }

  static func symbolList() -> APIRequest<[Symbol]> {
    return APIRequest.init(host: APIRequest<Symbol>.Constants.IEXHostName,
                           methodType: HTTPMethod.get,
                           path: "1.0/ref-data/symbols",
                           modelClass: Array<Symbol>.self)
  }
}
