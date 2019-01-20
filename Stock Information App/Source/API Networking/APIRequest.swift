import Alamofire
import Foundation

struct APIRequestConstants {
  static let IEXHostName: String = "https://api.iextrading.com/"
}

struct APIRequest<ModelClass: Codable> {

  // MARK: Stored Properties
  var host: String // i.e. https://api.iextrading.com
  var methodType: Alamofire.HTTPMethod
  var modelClass: ModelClass.Type
  var path: String

  var url: URL? {
    return URL(string: host + path)
  }

  init(host: String, methodType: Alamofire.HTTPMethod, path: String, modelClass: ModelClass.Type) {
    self.path = path
    self.host = host
    self.methodType = methodType
    self.modelClass = modelClass
  }
}
