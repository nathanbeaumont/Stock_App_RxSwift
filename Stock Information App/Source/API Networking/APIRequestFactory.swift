import Alamofire
import Foundation

class APIRequestFactory {

  class func stockAPIRequest(tickerSymbol: String) -> APIRequest<Stock> {
    return APIRequest.init(host: APIRequestConstants.IEXHostName,
                           methodType: HTTPMethod.get,
                           path: "1.0/stock/\(tickerSymbol)/quote",
                           modelClass: Stock.self)
  }
}
