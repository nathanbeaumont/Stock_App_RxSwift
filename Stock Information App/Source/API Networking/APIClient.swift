import Alamofire
import Foundation
import RxSwift

class APIClient<APIModel: Codable> {
  enum FailureReason: Int, Error {
    case unAuthorized = 401
    case notFound = 404
  }

  class func perform(Request apiRequest: APIRequest<APIModel>) -> Observable<APIModel> {
    return Observable.create({ observer -> Disposable in
      Alamofire.request(apiRequest.url!)
        .validate()
        .responseJSON(completionHandler: { response in
          switch response.result {
          case .success:
            guard let data = response.data else {
              observer.onError(response.error ?? FailureReason.unAuthorized)
              return
            }

            do {
              let model = try JSONDecoder().decode(apiRequest.modelClass, from: data)
              observer.onNext(model)
            } catch {
              observer.onError(error)
            }

          case .failure(let error):
            if let statusCode = response.response?.statusCode,
              let reason = FailureReason(rawValue: statusCode) {
              observer.onError(reason)
            }

            observer.onError(error)
          }
        })

      return Disposables.create()
    })
  }
}
