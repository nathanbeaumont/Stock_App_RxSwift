import RxSwift
import UIKit

class ViewController: UIViewController {

  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    let apiRequest = APIRequestFactory.stockAPIRequest(tickerSymbol: "AAPL")
    APIClient
      .perform(Request: apiRequest)
      .subscribe(onNext: { stock in
        print(stock)
      }, onError: { error in
        print(error)
      })
      .disposed(by: disposeBag)
  }
}

