import Foundation
import RxSwift
import RxCocoa
import UIKit
import Toast_Swift

class AddStockViewController: UIViewController {

  // MARK: Outlets
  @IBOutlet weak var stockTickerTextField: UITextField!
  @IBOutlet weak var topBackgroundView: UIView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var topLabel: UILabel!

  // MARK: Stored Properties
  private let disposeBag: DisposeBag = DisposeBag()
  private let stockInformationCellIdentifier = String(describing: StockInformationCell.self)
  private var symbolList: Array<Symbol> = []
  private var symbolListDataSource: PublishSubject<Array<Symbol>> = PublishSubject.init()
  private var symbolListFiltered: Variable<Array<Symbol>> = Variable.init([])
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
  }

  private func setupTextField() {
    stockTickerTextField.rx
      .text.orEmpty
      .bind(to: self.symbolText)
      .disposed(by: disposeBag)

    symbolText
      .asObservable()
      .throttle(0.5, scheduler: MainScheduler.instance)
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

  // MARK: TablieView DataSource & Delegate Observers

  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = nil
    tableView.tableFooterView = UIView()
    symbolListDataSource.bind(to: symbolListFiltered).disposed(by: disposeBag)
    symbolListDataSource
      .bind(to: tableView.rx.items(cellIdentifier: stockInformationCellIdentifier)) { index, model, cell in
        guard let cell = cell as? StockInformationCell else {
          return
        }

        cell.companyNameLabel.text = model.name
        cell.stockTickerLable.text = model.symbolTicker
      }
      .disposed(by: disposeBag)

    tableView.rx.itemSelected
      .subscribe(onNext: { [weak self] indexPath in
        if let symbol = self?.symbolListFiltered.value[indexPath.row] {
          let errorStatus = StockListDataBaseManager.shared.addStock(symbol: symbol.symbolTicker)
          if errorStatus == .none {
            self?.view.isUserInteractionEnabled = false
            let toastMessage = "\(symbol.symbolTicker)" + " was added to your list."
            self?.view.makeToast(toastMessage, point: self?.view.center ?? CGPoint.zero,
                                 title: "Success",
                                 image: nil, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + ToastManager.shared.duration) {
              self?.dismiss(animated: true, completion: nil)
            }
          } else if errorStatus == .stockAlreadyAdded  {
            self?.view.isUserInteractionEnabled = true
            self?.view.makeToast("Symbol already added: \(symbol.symbolTicker)",
              point: self?.view.center ?? CGPoint.zero,
              title: "Whoops",
              image: nil, completion: nil)
          } else if errorStatus == .fileWrite  {
            self?.view.isUserInteractionEnabled = true
            self?.view.makeToast("Could not add Symbol: \(symbol.symbolTicker)",
                                point: self?.view.center ?? CGPoint.zero,
                                title: "Error",
                                image: nil, completion: nil)
          }
        }
      }).disposed(by: disposeBag)
  }
}

extension AddStockViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 55.0
  }
}
