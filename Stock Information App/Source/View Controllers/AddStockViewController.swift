import Foundation
import RxSwift
import RxCocoa
import UIKit

class AddStockViewController: UIViewController {

  // MARK: Outlets
  @IBOutlet weak var stockTickerTextField: UITextField!
  @IBOutlet weak var topBackgroundView: UIView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var topLabel: UILabel!

  // MARK: Stored Properties
  private let cellIdentifier = "cellIdentifier"
  private let disposeBag: DisposeBag = DisposeBag()
  private var symbolList: Array<Symbol> = []
  private var symbolListDataSource: PublishSubject<Array<Symbol>> = PublishSubject.init()
  private var symbolText: Variable<String> = Variable("")

  //MARK: View Controller Methods
  override func viewDidLoad() {
    super.viewDidLoad()

    setupTableView()
    getSecuritySymbols()
    setupTextField()

    self.navigationItem.rightBarButtonItem?.action = #selector(dismissView)
    styleView()
  }

  private func styleView() {
    view.backgroundColor = UIColor.Custom.lightBlue
    topBackgroundView.backgroundColor = UIColor.Custom.mediumBlue
    topLabel.textColor = UIColor.white
    topLabel.configureLabel(fontSize: 22.0)
    stockTickerTextField.textColor = UIColor.white
    stockTickerTextField.autocorrectionType = .no
    stockTickerTextField.font = UIFont.Custom.avenirFont(fontsize: 24.0)
    stockTickerTextField.backgroundColor = UIColor.Custom.lightBlue
    stockTickerTextField.attributedPlaceholder =
      NSAttributedString.init(string: "Stock ticker",
                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText,
                                           NSAttributedString.Key.font: UIFont.Custom.avenirFont(fontsize: 19.0)])
  }

  @objc private func dismissView() {
    dismiss(animated: true, completion: nil)
  }

  // MARK: Observer Creation Methods
  private func getSecuritySymbols() {
    APIClient.perform(Request: APIRequestFactory.symbolList())
      .asObservable()
      .take(1)
      .subscribe(onNext: { symbols in
        self.symbolList = symbols
        self.symbolListDataSource.onNext(symbols)
      })
      .disposed(by: disposeBag)

    symbolListDataSource.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { index, model, cell in
      cell.textLabel?.text = model.symbolTicker
    }
      .disposed(by: disposeBag)
  }

  private func setupTextField() {
    stockTickerTextField.rx
      .text.orEmpty
      .bind(to: self.symbolText)
      .disposed(by: disposeBag)

    symbolText
      .asObservable()
      .throttle(1.5, scheduler: MainScheduler.instance)
      .filter({ $0.count > 0 })
      .subscribe(onNext: { symbolList in
        let searchString = self.symbolText.value
        let filteredList = self.symbolList.filter({ symbol -> Bool in
          let stringMatch = symbol.symbolTicker.lowercased().range(of: searchString.lowercased())
          return stringMatch != nil ? true : false
        })

        self.symbolListDataSource.onNext(filteredList)
      })
      .disposed(by: disposeBag)

    symbolText
      .asObservable()
      .skip(1)
      .filter { $0.count == 0}
      .subscribe { _ in
        self.symbolListDataSource.onNext(self.symbolList)
      }
      .disposed(by: disposeBag)
  }

  private func setupTableView() {
    tableView.delegate = nil
    tableView.dataSource = nil

    tableView.tableFooterView = UIView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
  }
}
